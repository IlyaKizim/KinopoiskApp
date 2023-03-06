//
//  MyViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//

import UIKit


class MyViewController: UIViewController {
    
    private lazy var myViewModel = MyViewModel()
    
    private lazy var headerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = myViewModel.title
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: MyTableViewCell.identifire)
        tableView.register(MyTableViewCellTwo.self, forCellReuseIdentifier: MyTableViewCellTwo.identifire)
        tableView.register(MyTableViewCellWillShow.self, forCellReuseIdentifier: MyTableViewCellWillShow.identifire)
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    static var model: [Title] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadData()
    }
    
    private func setUp() {
        addSubViews()
        addConstraints()
        configureNavBar()
    }
    
    private func addSubViews() {
        view.addSubview(tableView)
        headerView.addSubview(label)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: tableView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor),
            label.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
//    static func set(with model: Title) {
//        self.model.append(model)
//    }
    
}

extension MyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        myViewModel.numberOfRowsInSection()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        myViewModel.array.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        myViewModel.array[section]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if MyTableViewCellWillShow.dict.count == 0 {
        return CGFloat(myViewModel.heightForRow(indexPath: indexPath))
        } else {
        return CGFloat(myViewModel.heightForRowWithCount(indexPath: indexPath))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat(myViewModel.heightForHeaderInSection())
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.contentView.backgroundColor = .black
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCellWillShow.identifire, for: indexPath) as? MyTableViewCellWillShow else {return UITableViewCell()}
            cell.backgroundColor = .green
            if MyTableViewCellWillShow.dict.keys.count > 0 {
            cell.configure(with: MyViewController.model)
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.identifire, for: indexPath) as? MyTableViewCell else {return UITableViewCell()}
            cell.backgroundColor = .black
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCellTwo.identifire, for: indexPath) as? MyTableViewCellTwo else {return UITableViewCell()}
            return cell
        default:
            return UITableViewCell()
        }
        
    }
}
