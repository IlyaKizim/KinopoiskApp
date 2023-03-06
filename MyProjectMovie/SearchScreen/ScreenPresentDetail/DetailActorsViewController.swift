//
//  DetailActorsViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 15.02.2023.
//

import UIKit

class DetailActorsViewController: UIViewController {
    
    private lazy var detailViewModel = DetailViewModel()
    static var detail: DetailActor?
    private lazy var listMovieActors: [List] = []
    
    private lazy var headerView: UIView = {
        let headreView = UIView()
        headreView.backgroundColor = .black
        headreView.translatesAutoresizingMaskIntoConstraints = false
        return headreView
    }()
    
    private lazy var bgColorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var label: UILabel =  {
        let label = UILabel()
        label.backgroundColor = .black
        label.font = UIFont(name: "Helvetica Neue", size: 25)
        label.numberOfLines = 2
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Подробнее", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(detail), for: .touchUpInside)
        return button
    }()
    
    private lazy var textField: UITextView = {
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
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
        setUp()
    }
    
    private func setUp() {
        addSubviews()
        setConstraints()
    }
    
    private func setConstraints() {
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
            headerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            conteinerView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            conteinerView.widthAnchor.constraint(equalToConstant: 140),
            conteinerView.heightAnchor.constraint(equalToConstant: 170)
        ])
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: headerView.trailingAnchor,constant: -10),
            label.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            button.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 20),
            button.widthAnchor.constraint(equalToConstant: 100),
            button.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 15),
            textField.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 20),
            textField.widthAnchor.constraint(equalToConstant: 200),
            textField.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        headerView.addSubview(conteinerView)
        headerView.addSubview(button)
        headerView.addSubview(textField)
        headerView.addSubview(label)
        conteinerView.addSubview(posterImageView)
    }
    
    func setUps(with set: People) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(set.profilePath ?? "")") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        reloadData()
    }
    
    func configureLabel(with set: DetailActor) {
        self.label.text = set.name
        self.textField.text = "\(set.birthday ?? "")\n\(set.placeOfBirth ?? "")"
        reloadData()
    }
    
    func configureTableView(with model: [List]){
        self.listMovieActors = model
        reloadData()
    }
    
    func setUpForAnotherWay(with set: ActrosWhoPlaying) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(set.profilePath ?? "")") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        reloadData()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= view.safeAreaInsets.top + 40 {
            
            guard let text = label.text else {return}
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "\(text)", style: .done, target: self, action: #selector(back))
            navigationItem.leftBarButtonItem?.tintColor = .white
        } else if scrollView.contentOffset.y == view.safeAreaInsets.top {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    @objc private func back() {
        tableView.scrollToTop()
    }
    
    @objc private func detail() {
        let vc = DetailActorViewController()
        guard let detail =  DetailActorsViewController.detail else {return}
        vc.configure(with: detail)
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DetailActorsViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return detailViewModel.header
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listMovieActors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifire, for: indexPath) as?  DetailTableViewCell else {return UITableViewCell()}
        cell.backgroundColor = .black
        cell.selectedBackgroundView = bgColorView
        let model = listMovieActors[indexPath.row].posterPath ?? ""
        let twoModel = listMovieActors[indexPath.row].originalTitle ?? ""
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let modal = listMovieActors[indexPath.row]
        let model = Title(id: modal.id ?? 0, originalLanguage: modal.originalLanguage, originalTitle: modal.originalTitle, posterPath: modal.posterPath, overview: modal.overView, voteCount: modal.voteCount ?? 0, releaseDate: modal.releaseDate, voteAverage: modal.voteAverage)
       
        let vc = MovieDetailsViewControllers()
        vc.setUp(with: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
