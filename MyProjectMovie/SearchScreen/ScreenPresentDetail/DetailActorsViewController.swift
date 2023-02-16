//
//  DetailActorsViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 15.02.2023.
//

import UIKit
import Kingfisher

class DetailActorsViewController: UIViewController {
    
    private let detailViewModel = DetailViewModel()
    static var detail: DetailActor?
    var listMovieActors: [List] = []
    
    private lazy var headerView: UIView = {
        let headreView = UIView()
        headreView.frame.size = CGSize(width: view.bounds.width, height: 200)
        headreView.backgroundColor = .black
//        headreView.translatesAutoresizingMaskIntoConstraints = false
        return headreView
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 10, width: 140, height: 170))
        view.backgroundColor = .red
//        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var label: UILabel =  {
        let label = UILabel(frame: CGRect(x: 160, y: 10, width: view.bounds.width - 170, height: 50))
        label.backgroundColor = .black
        label.font = UIFont(name: "Helvetica Neue", size: 25)
        label.numberOfLines = 2
        label.textColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
       let button = UIButton(frame: CGRect(x: 160, y: 160, width: 100, height: 30))
        button.backgroundColor = .black
        button.setTitle("Подробнее", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        return button
    }()
    
    private lazy var textField: UITextView = {
        let textField = UITextView(frame: CGRect(x: 160, y: 70, width: 200, height: 80))
        textField.backgroundColor = .black
        textField.textColor = .gray
        textField.font = UIFont(name: "Helvetica Neue", size: 14)
        return textField
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.identifire)
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
    }
    override func viewDidLayoutSubviews() {
        posterImageView.frame = conteinerView.bounds
    }
    
    private func setUpView() {
        addSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
//            headerView.topAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.topAnchor),
//            headerView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
//            headerView.widthAnchor.constraint(equalToConstant: view.bounds.width),
//            headerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
//        NSLayoutConstraint.activate([
//            conteinerView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
//            conteinerView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
//            conteinerView.widthAnchor.constraint(equalToConstant: 140),
//            conteinerView.heightAnchor.constraint(equalToConstant: 170)
//        ])
//        NSLayoutConstraint.activate([
//            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
//            label.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 20),
//            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -10),
//            label.bottomAnchor.constraint(equalTo: headerView.bottomAnchor,constant: -10)
//        ])
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        headerView.addSubview(conteinerView)
        headerView.addSubview(button)
        
        
    }
    
    func setUps(with set: People) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(set.profilePath ?? "")") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        conteinerView.addSubview(posterImageView)
    }
    
    func configureLabel(with set: DetailActor) {
        self.label.text = set.name
        self.textField.text = "\(set.birthday ?? "")\n\(set.placeOfBirth ?? "")"
        headerView.addSubview(textField)
        headerView.addSubview(label)
    }
    
    func configureTableView(with model: [List]){
        self.listMovieActors = model
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
            
        }
    }
  
}

extension DetailActorsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return detailViewModel.header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listMovieActors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifire, for: indexPath) as?  DetailTableViewCell else {return UITableViewCell()}
        cell.backgroundColor = .black

        guard let model = listMovieActors[indexPath.row].posterPath else {return UITableViewCell()}
        guard let twoModel = listMovieActors[indexPath.row].originalTitle else {return UITableViewCell()}
        cell.configuration(with: model, twoModel: twoModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(detailViewModel.heightForRowAt())
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = UIFont(name: "Helvetica Neue", size: 18)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 150, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.tintColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitilizeFirstLetter()
    }
}
