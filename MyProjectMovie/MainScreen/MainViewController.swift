
import UIKit
import Kingfisher
import RxSwift

final class MainViewController: UIViewController {
    
// MARK: - UI Setup
    
    private lazy var headerView: UIView = ViewFactory.createHeaderView()
    private lazy var headerImageView: UIImageView = ViewFactory.createHeaderImageView()
    private lazy var headerLabel: UILabel = ViewFactory.createHeaderLabel()
    private lazy var headerOverView: UITextView = ViewFactory.createHeaderOverView()
    private lazy var tableView: UITableView = ViewFactory.createTableView()
    lazy var buttonDeleteFromInteresting: UIButton = ViewFactory.createButtonDeleteFromInteresting(target: self, action: #selector(deleteFromInteresting))
    lazy var buttonPlay: UIButton = ViewFactory.createButtonPlay(target: self, action: #selector(pushToPresents))
    lazy var buttonAddToInteresting: UIButton = ViewFactory.createButtonAddToInteresting(target: self, action: #selector(addToInteresting))

// MARK: - Properties
    
    private lazy var mainViewModel = MainViewModel(apiclient: APICaller())
    private lazy var disposeBag = DisposeBag()
    lazy var constraintButtonDeleteWidth: NSLayoutConstraint = NSLayoutConstraint()
    lazy var constraintButtonPlayHeight: NSLayoutConstraint = NSLayoutConstraint()
    lazy var constraintButtonAddHeight: NSLayoutConstraint = NSLayoutConstraint()
    lazy var constraintButtonAddWidth: NSLayoutConstraint = NSLayoutConstraint()
    
// MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configurationNavBar ()
        configureCornerRadius()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
}

//MARK: - UITableViewDelegate

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        NSLocalizedString(mainViewModel.titleForHeaderSection[section], comment: "")
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.setupHeader(header: header)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}

// MARK: - UITableViewDataSource

extension MainViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        mainViewModel.titleForHeaderSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifire , for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        
        switch indexPath.section {
        case Section.PopularMovies.rawValue:
            if case let .popular(data) = mainViewModel.movieData[0] {
                cell.bind(with: Observable.just(data))
            }
            
        case Section.TopRateMovie.rawValue:
            if case let .topRated(data) = mainViewModel.movieData[1] {
                cell.bind(with: Observable.just(data))
            }
            
        case Section.UpComingMovies.rawValue:
            if case let .upcoming(data) = mainViewModel.movieData[2] {
                cell.bind(with: Observable.just(data))
            }
            
        case Section.PlayingNowMoview.rawValue:
            if case let .favorites(data) = mainViewModel.movieData[3] {
                cell.bind(with: Observable.just(data))
            }
            
        case Section.TVshow.rawValue:
            if case let .watched(data) = mainViewModel.movieData[4] {
                cell.bind(with: Observable.just(data))
            }
            
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func updateData() {
        tableView.reloadData()
    }
}

//MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    
    @objc private func back() {
        tableView.scrollToTop()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        ScrollHelper.updateNavigationBarAppearance(scrollView.contentOffset.y, safeAreaInsetsTop: view.safeAreaInsets.top, navigationItem: navigationItem, backButtonAction: #selector(back))
    }
}

extension MainViewController {
    
// MARK: - View Setup
    
    private func setUpView() {
        addSubView()
        configureConstrains()
        binding()
        signDelegate()
    }
    
}

extension MainViewController {
    
// MARK: - UI Configuration
    
    private func configureCornerRadius() {
        buttonPlay.layer.cornerRadius = CGFloat(mainViewModel.radius)
        buttonDeleteFromInteresting.layer.cornerRadius =  CGFloat(mainViewModel.radius)
        buttonAddToInteresting.layer.cornerRadius =  CGFloat(mainViewModel.radius)
    }
    
    private func gradientForHeaderImage() {
        headerImageView.gradient(imageView: headerImageView)
    }
    
    private func configurationNavBar () {
        var image = UIImage(named: Constants.logo)
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func signDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MainViewController {
    
// MARK: - Event Handlers
    
    @objc private func pushToPresents() {
            let vc = PresentPlayViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.configure(with: VideoId.id)
            present(vc, animated: true, completion: nil)
        }
    
    @objc private func addToInteresting() {
        mainViewModel.addToInteresting()
    }
    
    @objc private func deleteFromInteresting() {
        mainViewModel.deleteFromInteresting()
    }
}

extension MainViewController {
    
// MARK: - Data Binding
    
    private func binding() {
        mainViewModel.headerTitleSubject.subscribe(onNext: { [weak self] titles in
            if let title = titles.first {
                self?.headerLabel.text = title.originalTitle
                if let posterPath = title.posterPath {
                    let imageUrl = URL(string: "\(ConstantsURL.image)\(posterPath)")
                    self?.headerImageView.kf.setImage(with: imageUrl)
                }
                self?.headerOverView.text = title.overview
            }
        }).disposed(by: disposeBag)
        
        mainViewModel.shouldReloadTableViewPublishSubject.subscribe(onNext: { [weak self] _ in
            self?.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        mainViewModel.addToInterestingObservable.subscribe(onNext: { [weak self] in
            self?.didAddToInteresting()
        }).disposed(by: disposeBag)
        
        mainViewModel.deleteFromAddToInterestingObservable.subscribe(onNext: { [weak self] in
            self?.didRemoveFromInteresting()
        }).disposed(by: disposeBag)
        
        mainViewModel.deleteFromInterestingObservable.subscribe(onNext: { [weak self] in
            self?.didDeleteFromInteresting()
        }).disposed(by: disposeBag)
        
        mainViewModel.removeFromInterestingObservable.subscribe(onNext: { [weak self] in
            self?.didDeleteRemoveFromInteresting()
        }).disposed(by: disposeBag)
    }
}

extension MainViewController {
    
// MARK: - Animation Button
    
    func didAddToInteresting() {
        AnimationHelper.animateAddToInteresting(on: self)
    }
    
    func didRemoveFromInteresting() {
        AnimationHelper.animateRemoveFromInteresting(on: self)
    }
    
    func didDeleteFromInteresting() {
        AnimationHelper.animateDeleteFromInteresting(on: self)
    }
    
    func didDeleteRemoveFromInteresting() {
        AnimationHelper.animateDeleteRemoveFromInteresting(on: self)
    }
}


extension MainViewController {
    
// MARK: - Constraints
    
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
}

extension MainViewController {
    
// MARK: - AddSubView
    
    private func addSubView() {
        view.addSubview(tableView)
        tableView.tableHeaderView = headerView
        headerView.addSubview(headerImageView)
        headerView.addSubview(headerLabel)
        headerView.addSubview(headerOverView)
        headerView.addSubview(buttonPlay)
        headerView.addSubview(buttonDeleteFromInteresting)
        headerView.addSubview(buttonAddToInteresting)
    }
}

//MARK: - Navigation

extension MainViewController: TitleSelectionDelegate {
    func didSelectTitle(_ title: Title) {
            let movieDetailsVC = MovieDetailsViewControllers()
            movieDetailsVC.setUps(with: title)
            navigationController?.pushViewController(movieDetailsVC, animated: true)
        }
}
