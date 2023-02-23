//
//  SearchResultsControllerViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 03.02.2023.
//

import UIKit

class SearchResultsControllerViewController: UIViewController {
    
    public lazy var titles: [Title] = [Title]()
    
    public lazy var tableViewForSearch: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchresultTableViewTableViewCell.self, forCellReuseIdentifier: SearchresultTableViewTableViewCell.identifire)
        return tableView
    }()
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchresultTableViewTableViewCell.identifire, for: indexPath) as? SearchresultTableViewTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.backgroundColor = .black
        cell.configures(with: title.posterPath ?? "", with: title.originalTitle ?? "", with: title.voteAverage ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
}
