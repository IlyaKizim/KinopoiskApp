import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDelegate(cell: CollectionViewTableViewCell, viewModel: Title)
}

final class CollectionViewTableViewCell: UITableViewCell {
    
    static let identifire = "CollectionViewTableViewCell"
    weak var delegate: CollectionViewTableViewCellDelegate?
    private var titles: [Title] = [Title]()
    private let mainViewModel = MainViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdentifiers: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifiers)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(collectionView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        
        let model = titles[indexPath.row]
        cell.configuration(with: model)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        mainViewModel.getMovies(indexPath: indexPath, title: titles)
        
        let viewModel = Title(id: titles[indexPath.row].id, originalLanguage: titles[indexPath.row].originalLanguage, originalTitle: titles[indexPath.row].originalTitle, posterPath: titles[indexPath.row].posterPath, overview: titles[indexPath.row].overview, voteCount: titles[indexPath.row].voteCount, releaseDate: titles[indexPath.row].releaseDate, voteAverage: titles[indexPath.row].voteAverage)
        
        delegate?.collectionViewTableViewCellDelegate(cell: self, viewModel: viewModel)
    }
}


