import UIKit

protocol SearchResultsControllerViewControllerDelegate: AnyObject {
    func searchResultsControllerViewControllerDelegate (model: Title)
}

final class SearchResultsControllerViewController: UIViewController {
    
    private lazy var bgColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    public lazy var tableViewForSearch: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchresultTableViewTableViewCell.self, forCellReuseIdentifier: SearchresultTableViewTableViewCell.identifire)
        return tableView
    }()
    
    lazy var titles = [Title]()
    weak var delegate: SearchResultsControllerViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp ()
    }

    private func setUp () {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(tableViewForSearch)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableViewForSearch.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableViewForSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableViewForSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableViewForSearch.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension SearchResultsControllerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func reloadData() {
        tableViewForSearch.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchresultTableViewTableViewCell.identifire, for: indexPath) as? SearchresultTableViewTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.backgroundColor = .black
        cell.selectedBackgroundView = bgColorView
        cell.configuration(with: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = titles[indexPath.row]
        delegate?.searchResultsControllerViewControllerDelegate(model: title)
    }
}

