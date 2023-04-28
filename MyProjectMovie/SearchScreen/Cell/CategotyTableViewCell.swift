import UIKit

final class CategotyTableViewCell: UITableViewCell {
    
    static let identifire = "CategotyTableViewCell"
    private lazy var arrayCategory = ["Фильмы", "Онлайн-кинотеатр", "Жанры", "Страны", "Годы", "Критика", "Сериалы", "Сборы", "Премии", "Направления"]
    
    private lazy var collectionView: UICollectionView = {
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: screenWidth/5, height: screenWidth/7.5)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.register(CategotyCollectionViewCell.self, forCellWithReuseIdentifier: CategotyCollectionViewCell.identifire)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdentifiers: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifiers)
        addSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    private func addSubviews() {
        contentView.addSubview(collectionView)
    }
}

extension CategotyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategotyCollectionViewCell.identifire, for: indexPath) as? CategotyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureTextLabel(with: arrayCategory[indexPath.row])
        return cell
    }
}
