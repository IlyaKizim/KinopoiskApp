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
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .black
        tableView.register(SearchresultTableViewTableViewCell.self, forCellReuseIdentifier: SearchresultTableViewTableViewCell.identifire)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableViewForSearch.frame = view.bounds
    }
    
    private func setupTableView (){
        tableViewForSearch.delegate = self
        tableViewForSearch.dataSource = self
    }
    
    private func addSubviews() {
        view.addSubview(tableViewForSearch)
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
