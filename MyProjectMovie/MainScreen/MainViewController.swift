//
//  MainViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//

import UIKit
import Kingfisher

enum Section: Int {
    
    case PopularMovies = 0
    case TopRateMovie
    case UpComingMovies
    case PlayingNowMoview
    case TVshow
}

class MainViewController: UIViewController {
    
    private lazy var headerView: UIView = {
        var headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private lazy var headView: UIView = {
        var view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var headerImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    private var buttonPlay: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9986565709, green: 0.3295648098, blue: 0.00157311745, alpha: 1)
        button.layer.cornerRadius = 20
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .white
        button.setTitle("  Смотреть", for: .normal)
        button.addTarget(self, action: #selector(pushToPresents), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonAddToInteresting: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setImage(UIImage(systemName: "note.text.badge.plus"), for: .normal)
        button.addTarget(self, action: #selector(addToInteresting), for: .touchUpInside)
        button.layer.cornerRadius = 20
        button.tintColor = .white
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        return label
    }()
    
    private lazy var headerOverView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .black
        text.textColor = .white
        return text
    }()
    
    private lazy var buttonDeleteFromInteresting: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setImage(UIImage(systemName: "minus.circle"), for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(deleteFromInteresting), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifire)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.tableHeaderView = headerView
        return tableView
    }()
    
    private lazy var mainViewModel = MainViewModel()
    private lazy var cellDataSource: [[Title]] = []
    private lazy var integer = 0
    private lazy var randomInt = Int.random(in: 0..<integer)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar ()
        setUpView()
        bindindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainViewModel.getData()
    }
    
    private func setUpView() {
        addSubView()
        configureConstrains()
    }
    
    private func addSubView() {
        view.addSubview(tableView)
        headerView.addSubview(headView)
        headView.addSubview(headerImageView)
        headerView.addSubview(headerLabel)
        headerView.addSubview(headerOverView)
        headerView.addSubview(buttonPlay)
        headerView.addSubview(buttonDeleteFromInteresting)
        headerView.addSubview(buttonAddToInteresting)
    }
    
    private func configureConstrains() {
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
            headerView.heightAnchor.constraint(equalToConstant: 550)
        ])
        NSLayoutConstraint.activate([
            headView.topAnchor.constraint(equalTo: headerView.topAnchor),
            headView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: headView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: headView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: headView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: headView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headView.bottomAnchor, constant: 10),
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            headerLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            headerOverView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 10),
            headerOverView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            headerOverView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            headerOverView.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            buttonPlay.topAnchor.constraint(equalTo: headerOverView.bottomAnchor, constant: 10),
            buttonPlay.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 50),
            buttonPlay.trailingAnchor.constraint(equalTo: buttonAddToInteresting.leadingAnchor, constant: -10),
            buttonPlay.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            buttonDeleteFromInteresting.topAnchor.constraint(equalTo: headerOverView.bottomAnchor, constant: 10),
            buttonDeleteFromInteresting.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -50),
            buttonDeleteFromInteresting.widthAnchor.constraint(equalToConstant: 40),
            buttonDeleteFromInteresting.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            buttonAddToInteresting.topAnchor.constraint(equalTo: headerOverView.bottomAnchor, constant: 10),
            buttonAddToInteresting.trailingAnchor.constraint(equalTo: buttonDeleteFromInteresting.leadingAnchor, constant: -10),
            buttonAddToInteresting.widthAnchor.constraint(equalToConstant: 40),
            buttonAddToInteresting.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func bindindViewModel() {
        mainViewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self, let movies = movies else {return}
            self.cellDataSource = movies
            self.integer = movies[0].count
            self.configureHeaderView(with: movies)
            self.reloadData()
        }
    }
    
    private func configureHeaderView(with model: [[Title]]) {
        if model[0].count > 1 {
            let text = model[0]
            self.headerLabel.text = text[randomInt].originalTitle
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(text[randomInt].posterPath ?? "")") else {
                return
            }
            headerImageView.kf.setImage(with: url)
            headerOverView.text = text[randomInt].overview
            mainViewModel.getMovies(indexPath: [0, randomInt], title: text)
        }
    }
    
    private func configurationNavBar () {
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc private func pushToPresents() {
        let vc = PresentPlayViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.configure(with: MovieDetailsViewControllers.model)
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func addToInteresting() {
        print("add")
    }
    
    @objc private func deleteFromInteresting() {
        print("delete")
    }
}

// MARK: Extension for Delegate and DataSource.

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        mainViewModel.titleForHeaderSection[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.contentView.backgroundColor = .black
        header.textLabel?.text = header.textLabel?.text?.capitilizeFirstLetter()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        mainViewModel.titleForHeaderSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(mainViewModel.heightForRowAt())
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        CGFloat(mainViewModel.heightForHeaderInSection())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifire , for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        if cellDataSource.count > 0 {
            switch indexPath.section {
            
            case Section.PopularMovies.rawValue:
                cell.configure(with: cellDataSource[0])
                
            case Section.TopRateMovie.rawValue:
                cell.configure(with: cellDataSource[1])
                
            case Section.UpComingMovies.rawValue:
                cell.configure(with: cellDataSource[2])
                
            case Section.PlayingNowMoview.rawValue:
                cell.configure(with: cellDataSource[3])
                
            case Section.TVshow.rawValue:
                cell.configure(with: cellDataSource[4])
                
            default:
                return UITableViewCell()
            }
        }
        return cell
    }
    
    //MARK: ScrollView BarButtonItem and BackToTopView
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= view.safeAreaInsets.top + 40 {
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: nil, style: .done, target: self, action: nil)
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Главная", style: .done, target: self, action: #selector(back))
            navigationItem.leftBarButtonItem?.tintColor = .white
        } else if scrollView.contentOffset.y == view.safeAreaInsets.top {
            var image = UIImage(named: "logo")
            image = image?.withRenderingMode(.alwaysOriginal)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        }
    }
    
    @objc private func back() {
        tableView.scrollToTop()
    }
}

extension UIScrollView {
    
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
}

extension MainViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDelegate(cell: CollectionViewTableViewCell, viewModel: Title) {
        let vc = MovieDetailsViewControllers()
        vc.setUp(with: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
