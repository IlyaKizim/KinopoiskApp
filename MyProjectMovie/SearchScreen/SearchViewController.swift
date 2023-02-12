//
//  SearchViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    private lazy var searcViewModel = SearchViewModel()
    private lazy var tableView: UITableView = {
       
        let tableView = UITableView(frame: .zero, style: .grouped)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifire)
        tableView.register(CategotyTableViewCell.self, forCellReuseIdentifier: CategotyTableViewCell.identifire)
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.searchController = controller
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = .black
        return tableView
    }()
    
    private lazy var controller: UISearchController = {
       let controller = UISearchController(searchResultsController: SearchResultsControllerViewController())
        controller.searchBar.placeholder = searcViewModel.searchPlaceholder
        controller.searchBar.searchTextField.backgroundColor = #colorLiteral(red: 0.1489986479, green: 0.1490316391, blue: 0.1489965916, alpha: 1)
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setConstraint()
        addSubviews ()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func addSubviews () {
        let header = HeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 1))
        controller.searchResultsUpdater = self
        view.backgroundColor = .black
        view.addSubview(header)
        view.addSubview(tableView)
    }
    
//    private func setConstraint() {
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }

}
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        searcViewModel.array[section]
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitilizeFirstLetter()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 1, 2: guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifire, for: indexPath) as? SearchTableViewCell else {
            return  UITableViewCell()
        }
        return cell
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategotyTableViewCell.identifire, for: indexPath) as? CategotyTableViewCell else {
                return  UITableViewCell()
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        searcViewModel.array.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 220
        case 1: return 200
        case 2: return 200
        default:
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
}
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsControllerViewController else { return }
        APICaller.shared.search(with: query) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultController.titles = titles
                    resultController.tableViewForSearch.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
