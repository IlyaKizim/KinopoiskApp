//
//  MainViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//
//MARK: Влад, Прости за говнокод!!! Уверен, что у тебя будет так много вопрос и так мало ответов) Удачи!)

import UIKit
import Kingfisher

class MainViewController: UIViewController {
    
    private lazy var headerView: UIView = {
        var headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }()
    
    private lazy var headerImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var buttonPlay: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9986565709, green: 0.3295648098, blue: 0.00157311745, alpha: 1)
        button.layer.cornerRadius = radius
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
        button.layer.cornerRadius = radius
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
        button.layer.cornerRadius = radius
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
    
    private lazy var radius: CGFloat = 20
    private lazy var mainViewModel = MainViewModel()
    private lazy var cellDataSource: [[Title]] = []
    private lazy var integer = 0
    private lazy var randomInt = Int.random(in: 0..<integer)//это число для того, чтобы брать данные из модели и вставлять в header tableView, чтобы были разные.
    private lazy var isActivateAdd = false
    private lazy var isActivateDel = false
    // это для анимации, при нажатии на кнопки, чтобы менялись констрейны.
    private lazy var constraintButtonDeleteWidth: NSLayoutConstraint = NSLayoutConstraint()
    private lazy var constraintButtonPlayHeight: NSLayoutConstraint = NSLayoutConstraint()
    private lazy var constraintButtonAddHeight: NSLayoutConstraint = NSLayoutConstraint()
    private lazy var constraintButtonAddWidth: NSLayoutConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurationNavBar ()
        setUpView()
        bindindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mainViewModel.getData()//делаю запрос на сервер для получения данных в коллекцию
    }
    
    private func setUpView() {
        addSubView()
        configureConstrains()
    }
    
    private func addSubView() {
        view.addSubview(tableView)
        headerView.addSubview(headerImageView)
        headerView.addSubview(headerLabel)
        headerView.addSubview(headerOverView)
        headerView.addSubview(buttonPlay)
        headerView.addSubview(buttonDeleteFromInteresting)
        headerView.addSubview(buttonAddToInteresting)
    }
    
    private func configureConstrains() {
        constraintButtonDeleteWidth = buttonDeleteFromInteresting.widthAnchor.constraint(equalToConstant: 40)
        constraintButtonPlayHeight = buttonPlay.heightAnchor.constraint(equalToConstant: 40)
        constraintButtonAddHeight = buttonAddToInteresting.heightAnchor.constraint(equalToConstant: 40)
        constraintButtonAddWidth = buttonAddToInteresting.widthAnchor.constraint(equalToConstant: 40)
        
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
            headerImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10),
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
            buttonPlay.widthAnchor.constraint(equalToConstant: view.bounds.width / 2.5),
            constraintButtonPlayHeight
        ])
        NSLayoutConstraint.activate([
            buttonDeleteFromInteresting.topAnchor.constraint(equalTo: headerOverView.bottomAnchor, constant: 10),
            buttonDeleteFromInteresting.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -50),
            constraintButtonDeleteWidth,
            buttonDeleteFromInteresting.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            buttonAddToInteresting.topAnchor.constraint(equalTo: headerOverView.bottomAnchor, constant: 10),
            buttonAddToInteresting.trailingAnchor.constraint(equalTo: buttonDeleteFromInteresting.leadingAnchor, constant: -10),
            constraintButtonAddWidth,
            constraintButtonAddHeight
        ])
    }
    
    private func bindindViewModel() { //это я забиндил данные, которые получил из запроса и сохраняю их тут
        mainViewModel.cellDataSource.bind { [weak self] movies in
            guard let self = self, let movies = movies else {return}
            self.cellDataSource = movies
            self.integer = movies[0].count
            self.configureHeaderView(with: movies)
            self.reloadData()
        }
    }
    
    private func configureHeaderView(with model: [[Title]]) {
        if model[0].count > 1 { // > 1 потому что если массив будет пустой то из-за рандомного числа будет error ну и эти данные вставляю в header tableView
            let text = model[0]
            self.headerLabel.text = text[randomInt].originalTitle
            guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(text[randomInt].posterPath ?? "")") else {
                return
            }
            headerImageView.kf.setImage(with: url)
            headerOverView.text = text[randomInt].overview
            mainViewModel.getMovies(indexPath: [0, randomInt], title: text)
            gradientForHeaderImage()
        }
    }
    
    private func gradientForHeaderImage() { // это затемнение снизу на постере в header
        let imageHeight = headerImageView.image?.size.height ?? 300
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.withAlphaComponent(0.6).cgColor]
        gradient.locations = [0, 1]
        gradient.frame = CGRect(x: 0, y: imageHeight * 0.8, width: headerImageView.bounds.width, height: imageHeight * 0.2)
        headerImageView.layer.addSublayer(gradient)
    }
    
    private func configurationNavBar () { //картинка кинопоиска в navigationController
        var image = UIImage(named: "logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc private func pushToPresents() { //открытие экрана кноки "смотреть"
        let vc = PresentPlayViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.configure(with: MovieDetailsViewControllers.model)
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func addToInteresting() {//этот ужас для анимации при нажатии.
        //MARK: но я сколько не ебался, так и не понял как сделать, чтобы текст на кнопки был четким, а не как зрение -8
        if !isActivateDel {
            UIView.animate(withDuration: 0.3) {
                self.constraintButtonAddWidth.constant = self.view.bounds.width / 1.5
                self.constraintButtonPlayHeight.constant = 0
                self.constraintButtonDeleteWidth.constant = 0
                self.buttonAddToInteresting.setTitle(" Добавлено", for: .normal)
                self.buttonAddToInteresting.tintColor = .orange
                self.buttonAddToInteresting.titleLabel?.adjustsFontSizeToFitWidth = true
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 0.3, delay: 2.5, options: [], animations: {
                    self.buttonAddToInteresting.setTitleColor(.orange, for: .normal)
                    self.constraintButtonAddWidth.constant = 40
                    self.constraintButtonDeleteWidth.constant = 40
                    self.constraintButtonPlayHeight.constant = 40
                    self.buttonPlay.setTitle("", for: .normal)
                    self.view.layoutIfNeeded()
                }, completion: {_ in
                    self.buttonPlay.setTitle("  Смотреть", for: .normal)
                    self.buttonAddToInteresting.setTitle("", for: .normal)
                    self.view.layoutIfNeeded()
                })
            }
            // здесь я сохраняю данные в дикшинари. Это для добавления фильмов в myController, а дикшинари, для того, чтобы можно было удалить по ключу фильмы, которые добавил в закладки
            let title = cellDataSource[0]
            let model = title[randomInt]
            MyTableViewCellWillShow.dict[model.originalTitle ?? "No"] = [model]
            self.isActivateDel = true
            
        } else {
            UIView.animate(withDuration: 0.3) {
                self.buttonAddToInteresting.tintColor = .white
            }
            //здесь удаляю из дикшинари и из закладок.
            let title = cellDataSource[0]
            let model = title[randomInt]
            MyTableViewCellWillShow.dict.removeValue(forKey: model.originalTitle ?? "No")
            self.isActivateDel = false
           
        }
    }
    
    @objc private func deleteFromInteresting() {//анимация для второй кнопки "неинтересно"
        if !isActivateAdd {
            UIView.animate(withDuration: 0.3) {
                self.constraintButtonDeleteWidth.constant = (self.view.bounds.width / 1.5) + 40
                self.constraintButtonPlayHeight.constant = 0
                self.constraintButtonAddHeight.constant = 0
                self.buttonDeleteFromInteresting.setTitle(" Неинтересно", for: .normal)
                self.buttonDeleteFromInteresting.tintColor = .orange
                self.buttonDeleteFromInteresting.titleLabel?.adjustsFontSizeToFitWidth = true
                self.view.layoutIfNeeded()
                UIView.animate(withDuration: 0.3, delay: 2.5, options: [], animations: {
                    self.buttonDeleteFromInteresting.setTitleColor(.orange, for: .normal)
                    self.constraintButtonDeleteWidth.constant = 40
                    self.constraintButtonPlayHeight.constant = 40
                    self.constraintButtonAddHeight.constant = 40
                    self.buttonPlay.setTitle("", for: .normal)
                    self.view.layoutIfNeeded()
                }, completion: {_ in
                    self.buttonPlay.setTitle("  Смотреть", for: .normal)
                    self.buttonDeleteFromInteresting.setImage(UIImage(systemName: "minus.circle"), for: .normal)
                    self.buttonDeleteFromInteresting.setTitle("", for: .normal)
                    self.view.layoutIfNeeded()
                    self.isActivateAdd = true
                })
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.buttonDeleteFromInteresting.tintColor = .white
            }
            self.isActivateAdd = false
        }
    }
}

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
        //Это шрифт, текст итд для заголовков в табилце
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
        if cellDataSource.count > 0 { //>0 потому, если будет пустой массив - error, Ну и соответственно этот ужас с индексами и массивами, чтобы можно было до каждого запроса, полученного из сервера, достучаться.
            switch indexPath.section {
            
            case MainViewModel.Section.PopularMovies.rawValue:
                cell.configure(with: cellDataSource[0])
                
            case MainViewModel.Section.TopRateMovie.rawValue:
                cell.configure(with: cellDataSource[1])
                
            case MainViewModel.Section.UpComingMovies.rawValue:
                cell.configure(with: cellDataSource[2])
                
            case MainViewModel.Section.PlayingNowMoview.rawValue:
                cell.configure(with: cellDataSource[3])
                
            case MainViewModel.Section.TVshow.rawValue:
                cell.configure(with: cellDataSource[4])
                
            default:
                return UITableViewCell()
            }
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // при скролле вниз появляется заголовок, а если обратно вренуть, то обратно логотип
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
    // делегат для пуша
    func collectionViewTableViewCellDelegate(cell: CollectionViewTableViewCell, viewModel: Title) {
        let vc = MovieDetailsViewControllers()
        vc.setUps(with: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}
