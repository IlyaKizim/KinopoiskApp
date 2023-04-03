//
//  PresentViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 18.01.2023.


import UIKit
import CoreData

class MovieDetailsViewControllers: UIViewController {
    
    private lazy var headerview: UIView = {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .clear
        return headerView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieDetailsTableViewCell.self, forCellReuseIdentifier: MovieDetailsTableViewCell.identifire)
        tableView.register(MovieDetailsActorsCellTableView.self, forCellReuseIdentifier: MovieDetailsActorsCellTableView.identifire)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = headerview
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var overView: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont(name: "Helvetica Neue", size: 14)
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.isScrollEnabled = false
        text.textColor = .gray
        return text
    }()
    
    private lazy var releaseDate: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont(name: "Helvetica Neue", size: 14)
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.isScrollEnabled = false
        text.textColor = .gray
        return text
    }()
    
    private lazy var vouteAverage: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont(name: "Helvetica Neue", size: 14)
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.isScrollEnabled = false
        return text
    }()
    
    private lazy var originalLanguageLabel: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont(name: "Helvetica Neue", size: 14)
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.textColor = .gray
        text.isScrollEnabled = false
        return text
    }()
    
    private lazy var buttonPlay: UIButton = {
        let buttonPlay = UIButton()
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.backgroundColor = #colorLiteral(red: 0.9986565709, green: 0.3295648098, blue: 0.00157311745, alpha: 1)
        buttonPlay.layer.cornerRadius = 20
        buttonPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
        buttonPlay.tintColor = .white
        buttonPlay.setTitle("  Смотреть", for: .normal)
        buttonPlay.addTarget(self, action: #selector(pushToPresent), for: .touchUpInside)
        return buttonPlay
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var buttonDoRate: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Оценить", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.titleLabel?.textAlignment = .center
        button.titleEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 15)
        button.imageView?.contentMode = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 25, right: 0)
        button.tintColor = .gray
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(rate), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonWillShow: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Буду смотреть", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.titleEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 15)
        button.imageView?.contentMode = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 25, right: 0)
        button.tintColor = .gray
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(addWillSee), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonShare: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Поделиться", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.right.fill"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.titleLabel?.textAlignment = .center
        button.titleEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 15)
        button.imageView?.contentMode = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 35, bottom: 25, right: 0)
        button.tintColor = .gray
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(share), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonMore: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Ещё", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.setImage(UIImage(systemName: "ellipsis.circle"), for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 15)
        button.imageView?.contentMode = .center
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 25, right: 0)
        button.tintColor = .gray
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.addTarget(self, action: #selector(more), for: .touchUpInside)
        return button
    }()
    
    private lazy var label = 0.0
    static var model = ""
    private lazy var movieDetailViewModel = MovieDetailViewModel()
    private lazy var titles: [Title] = []
    private lazy var cellDataSource: [ActrosWhoPlaying] = []
    private lazy var flagRate = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUp()
    }
    
    private func setUp() {
        addSubviews()
        setConstraint()
        setNavBar()
    }
    
    private func addSubviews() {
        view.addSubview(conteinerView)
        view.addSubview(tableView)
        headerview.addSubview(titlelabel)
        headerview.addSubview(buttonPlay)
        headerview.addSubview(overView)
        headerview.addSubview(releaseDate)
        headerview.addSubview(vouteAverage)
        headerview.addSubview(originalLanguageLabel)
        headerview.addSubview(buttonDoRate)
        headerview.addSubview(buttonWillShow)
        headerview.addSubview(buttonShare)
        headerview.addSubview(buttonMore)
    }
    
    func setUps(with set: Title) {
        movieDetailViewModel.getData(query: String(set.id))
        bindindViewModel()
        self.titles.append(set)
        titlelabel.text = set.originalTitle
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(set.posterPath ?? "")") else {
            return
        }
        overView.text = set.overview
        let releaseDate = set.releaseDate ?? ""
        self.releaseDate.text = "Дата выхода: \(releaseDate)"
        posterImageView.kf.setImage(with: url)
        let voute = set.voteAverage ?? 0.0
        vouteAverage.textColor = vouteAverage.textColor?.changeRateColor(with: voute)
        vouteAverage.text = String(voute)
        self.label = voute
        let language = set.originalLanguage ?? ""
        originalLanguageLabel.text = "\u{1F50A} \(language)"
        conteinerView.addSubview(posterImageView)
    }
   
    private func bindindViewModel() {
        movieDetailViewModel.cellDataSource.bind { [weak self] actors in
            guard let self = self, let actors = actors else {return}
            self.cellDataSource = actors
            self.reloadData()
        }
    }
    
    private func setNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    private func setConstraint() {
        
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conteinerView.heightAnchor.constraint(equalToConstant: 300)
        ])
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            headerview.topAnchor.constraint(equalTo: tableView.topAnchor),
            headerview.leadingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leadingAnchor),
            headerview.trailingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.trailingAnchor),
            headerview.heightAnchor.constraint(equalToConstant: 700)
        ])
        NSLayoutConstraint.activate([
            titlelabel.topAnchor.constraint(equalTo: headerview.topAnchor, constant: 320),
            titlelabel.centerXAnchor.constraint(equalTo: headerview.centerXAnchor),
            titlelabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            titlelabel.heightAnchor.constraint(equalToConstant: 50),
        ])
        NSLayoutConstraint.activate([
            vouteAverage.topAnchor.constraint(equalTo: titlelabel.bottomAnchor),
            vouteAverage.centerXAnchor.constraint(equalTo: headerview.centerXAnchor),
            vouteAverage.widthAnchor.constraint(equalToConstant: 300),
            vouteAverage.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            overView.topAnchor.constraint(equalTo: vouteAverage.bottomAnchor),
            overView.centerXAnchor.constraint(equalTo: headerview.centerXAnchor),
            overView.widthAnchor.constraint(equalToConstant: 300),
            overView.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            releaseDate.topAnchor.constraint(equalTo: overView.bottomAnchor),
            releaseDate.centerXAnchor.constraint(equalTo: headerview.centerXAnchor),
            releaseDate.widthAnchor.constraint(equalToConstant: 300),
            releaseDate.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            originalLanguageLabel.topAnchor.constraint(equalTo: releaseDate.bottomAnchor),
            originalLanguageLabel.centerXAnchor.constraint(equalTo: headerview.centerXAnchor),
            originalLanguageLabel.widthAnchor.constraint(equalToConstant: 300),
            originalLanguageLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            buttonPlay.topAnchor.constraint(equalTo: originalLanguageLabel.bottomAnchor, constant: 10),
            buttonPlay.centerXAnchor.constraint(equalTo: headerview.centerXAnchor, constant: 0),
            buttonPlay.widthAnchor.constraint(equalToConstant: 150),
            buttonPlay.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            buttonDoRate.topAnchor.constraint(equalTo: buttonPlay.bottomAnchor, constant: 10),
            buttonDoRate.leadingAnchor.constraint(equalTo: headerview.leadingAnchor, constant: 10),
            buttonDoRate.widthAnchor.constraint(equalToConstant: (view.bounds.width / 4) - 10),
            buttonDoRate.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            buttonWillShow.topAnchor.constraint(equalTo: buttonPlay.bottomAnchor, constant: 10),
            buttonWillShow.leadingAnchor.constraint(equalTo: buttonDoRate.trailingAnchor, constant: 10),
            buttonWillShow.widthAnchor.constraint(equalToConstant: (view.bounds.width / 4) - 10),
            buttonWillShow.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            buttonShare.topAnchor.constraint(equalTo: buttonPlay.bottomAnchor, constant: 10),
            buttonShare.leadingAnchor.constraint(equalTo: buttonWillShow.trailingAnchor, constant: 10),
            buttonShare.widthAnchor.constraint(equalToConstant: (view.bounds.width / 4) - 10),
            buttonShare.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            buttonMore.topAnchor.constraint(equalTo: buttonPlay.bottomAnchor, constant: 10),
            buttonMore.leadingAnchor.constraint(equalTo: buttonShare.trailingAnchor, constant: 10),
            buttonMore.widthAnchor.constraint(equalToConstant: (view.bounds.width / 4) - 20),
            buttonMore.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    static func getmodalll(string: String) {
        MovieDetailsViewControllers.model = string
    }
    
    
    @objc private func back() {
        navigationController?.popToRootViewController(animated: true)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc func pushToPresent() {
        let vc = PresentPlayViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.configure(with: MovieDetailsViewControllers.model)
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func rate() {
        let vc = PresentRateViewController()
        present(vc, animated: true, completion: nil)
        vc.setUps(with: titles[0])
    }
    
    @objc private func addWillSee() {
        if !flagRate {
            MyTableViewCellWillShow.dict[titles[0].originalTitle ?? ""] = [titles[0]]
            movieDetailViewModel.saveCoreData(with: titles[0])
            buttonWillShow.tintColor = .orange
            flagRate = true
            
        } else {
            buttonWillShow.tintColor = .gray
            MyTableViewCellWillShow.dict.removeValue(forKey: titles[0].originalTitle ?? "")
            movieDetailViewModel.deleateCoreData(with: titles[0])
            flagRate = false
        }
    }
    
    @objc private func share() {
        let vc = PresentShareViewController()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func more() {
        movieDetailViewModel.deleateCoreData(with: titles[0])
        let vc = PresentMoreViewController()
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
}

extension MovieDetailsViewControllers: UITableViewDelegate, UITableViewDataSource {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (scrollView.contentOffset.y >= 0 && scrollView.contentOffset.y < (scrollView.contentSize.height - scrollView.frame.size.height)){
            let percentage: CGFloat = (scrollView.contentOffset.y) / 300
            posterImageView.alpha = (1 - percentage)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieDetailViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        movieDetailViewModel.arrayTitle[section]
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        movieDetailViewModel.arrayTitle.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(movieDetailViewModel.heightForRow(indexPath: indexPath))
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsTableViewCell.identifire, for: indexPath) as? MovieDetailsTableViewCell else {return UITableViewCell()}
            cell.delegate = self
            cell.configure(with: label, model: titles[0])
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieDetailsActorsCellTableView.identifire, for: indexPath) as? MovieDetailsActorsCellTableView else {return UITableViewCell()}
            cell.configure(with: cellDataSource)
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        header.textLabel?.textColor = .white
        header.textLabel?.adjustsFontSizeToFitWidth = true
        header.contentView.backgroundColor = .black
    }
}
extension MovieDetailsViewControllers: MovieDetailsDelegate {
    func presentRate(viewModel: Title) {
        let vc = PresentRateViewController()
        vc.setUps(with: titles[0])
        present(vc, animated: true, completion: nil)
    }
}

extension MovieDetailsViewControllers: CollectionViewCellDelegate {
    func CollectionViewCellDelegate(viewModel: ActrosWhoPlaying) {
        navigationController?.navigationBar.tintColor = .white
        let vc = DetailActorsViewController()
        movieDetailViewModel.getDataForDetail(with: vc, viewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)
    }
}

