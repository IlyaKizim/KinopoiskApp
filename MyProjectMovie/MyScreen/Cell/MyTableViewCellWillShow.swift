//
//  MyTableViewCellWillShow.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 05.03.2023.
//

import UIKit
import CoreData

protocol MyTableViewCellWillShowDelegate: AnyObject {
    func myTableViewCellWillShowDelegate(cell: MyTableViewCellWillShow, viewModel: Title)
}

class MyTableViewCellWillShow: UITableViewCell {
    
    static let identifire = "MyTableViewCellWillShow"
    weak var delegate: MyTableViewCellWillShowDelegate?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MyCollectionViewCellWillShow.self, forCellWithReuseIdentifier: MyCollectionViewCellWillShow.identifire)
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
    public func configure() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension MyTableViewCellWillShow: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MyViewModel.willSee.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCellWillShow.identifire, for: indexPath) as? MyCollectionViewCellWillShow else {return UICollectionViewCell()}
        cell.backgroundColor = .red
        let array = MyViewModel.willSee[indexPath.row]
        cell.configuration(with: array)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let array = MyViewModel.willSee[indexPath.row]
        let viewModel = Title(id: Int(array.id), originalLanguage: array.originalLanguage, originalTitle: array.originalTitle, posterPath: array.posterPath, overview: array.overview, voteCount: Int(array.voteCount), releaseDate: array.releaseDate, voteAverage: array.voteAverage)
        delegate?.myTableViewCellWillShowDelegate(cell: self, viewModel: viewModel)
    }
}
