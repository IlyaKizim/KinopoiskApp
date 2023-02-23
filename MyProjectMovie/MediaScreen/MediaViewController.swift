//
//  MediaViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//

import UIKit

class MediaViewController: UIViewController {
    
    private lazy var mediaViewModal = MediaViewModal()
    private lazy var cellDataSource: [News] = []
    
    private lazy var bgColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var viewForHeaderInSection: UILabel = {
       let label = UILabel()
        label.text = mediaViewModal.titleForHeaderSection
        label.textColor = .white
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        label.backgroundColor = .black
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .black
        tableView.register(MediaTableViewCell.self, forCellReuseIdentifier: MediaTableViewCell.identifire)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindindViewModel()
        setUp()
        configurationNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mediaViewModal.getData()
    }
    
    private func setUp() {
        addSubviews()
        addConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func bindindViewModel() {
        mediaViewModal.cellDataSource.bind { [weak self] movies in
            guard let self = self, let movies = movies else {return}
            self.cellDataSource = movies
            self.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= view.safeAreaInsets.top + 20 {
            
            let text = mediaViewModal.label
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "\(text)", style: .done, target: self, action: #selector(back))
            navigationItem.leftBarButtonItem?.tintColor = .white
        } else if scrollView.contentOffset.y <= view.safeAreaInsets.top + 20{
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc private func back() {
        tableView.scrollToTop()
    }
    
    private func configurationNavBar () {
        view.backgroundColor = .black
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
}

extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: MediaTableViewCell.identifire, for: indexPath) as? MediaTableViewCell
        else {
            return UITableViewCell()
        }
        cell.selectedBackgroundView = bgColorView
        cell.backgroundColor = .black
        let model = cellDataSource[indexPath.row]
        let labelData = model.publishedAt ?? ""
        let titleLabel = model.title ?? ""
        let posterImageView = model.urlToImage ?? ""
        cell.configure(with: labelData, titleLabel: titleLabel, posterImageView: posterImageView)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(mediaViewModal.heightForRowAt())
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        viewForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let url = URL(string: cellDataSource[indexPath.row].url ?? "")  else {return}
        UIApplication.shared.open(url)
    }
}
