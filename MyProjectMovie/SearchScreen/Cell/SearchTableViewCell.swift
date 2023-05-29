import UIKit

protocol TableViewCellDelegate: AnyObject {
    func tableViewCellDelegate(cell: SearchTableViewCell, viewModel: People)
}

final class SearchTableViewCell: UITableViewCell {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .black
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifire)
        return collectionView
    }()
    
    static let identifire = "SearchTableViewCell"
    weak var delegate: TableViewCellDelegate?
    private var titles: [People] = [People]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdentifiers: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifiers)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with titles: [People]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
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
}

extension SearchTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifire, for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        let model = titles[indexPath.row]
        cell.configuration(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = People(id: titles[indexPath.row].id, name: titles[indexPath.row].name, profilePath: titles[indexPath.row].profilePath)
        delegate?.tableViewCellDelegate(cell: self, viewModel: viewModel)
    }
}

