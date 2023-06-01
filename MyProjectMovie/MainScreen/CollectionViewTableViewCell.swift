
import UIKit
import RxSwift

//MARK: - Protocol

protocol TitleSelectionDelegate: AnyObject {
    func didSelectTitle(_ title: Title)
}

final class CollectionViewTableViewCell: UITableViewCell {
    
//MARK: - Properties
    
    static let identifire = "CollectionViewTableViewCell"
    private lazy var collectionView: UICollectionView = CellFactory.collectionView()
    private lazy var titles: [Title] = []
    weak var delegate: TitleSelectionDelegate?
    lazy var disposeBag = DisposeBag()
    
//MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdentifiers: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifiers)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Configure
    
    func bind(with titlesObservable: Observable<[Title]>) {
            titlesObservable
                .subscribe(onNext: { [weak self] titles in
                    self?.titles = titles
                    self?.collectionView.reloadData()
                })
                .disposed(by: disposeBag)
        }
}

//MARK: - UICollectionViewDelegate

extension CollectionViewTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
}

//MARK: - UICollectionViewDataSource

extension CollectionViewTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else { return UICollectionViewCell() }
        let model = titles[indexPath.row]
        cell.configuration(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedTitle = titles[indexPath.item]
            delegate?.didSelectTitle(selectedTitle)
    }
}

extension CollectionViewTableViewCell {
    
    //MARK: - Constraints
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}

extension CollectionViewTableViewCell {
    
    //MARK: - Setup UI
    
    private func setUp() {
        addSubviews()
        setConstraints()
        signDelegate()
    }
}

extension CollectionViewTableViewCell {
    
    //MARK: - AddSubviews
    
    private func addSubviews() {
        contentView.addSubview(collectionView)
    }
}

extension CollectionViewTableViewCell {
    
    //MARK: - SignDelegate
    
    private func signDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

