//
//  CollectionViewTableViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//

import UIKit

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDelegate(cell: CollectionViewTableViewCell, viewModel: Title)
}

class CollectionViewTableViewCell: UITableViewCell {
    
    weak var delegate: CollectionViewTableViewCellDelegate?
    private var titles: [Title] = [Title]()
    static let identifire = "CollectionViewTableViewCell"
    private let mainViewModel = MainViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdentifiers: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifiers)
        contentView.backgroundColor = .purple
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
        
    }
    public func configure(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
        }
    }
}

// MARK: Extension for CollectionView Delegate and DataSource

extension CollectionViewTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.identifire, for: indexPath) as? TitleCollectionViewCell else {return UICollectionViewCell()}
        
        guard let model = titles[indexPath.row].posterPath else {return UICollectionViewCell()}
        guard let voteAverage = titles[indexPath.row].voteAverage else {return UICollectionViewCell()}
        var label = titles[indexPath.row].originalTitle
        if label == nil {
            label = ""
        }
        cell.configures(with: model, with: voteAverage, with: label!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        mainViewModel.getMovies(indexPath: indexPath, title: titles)
        
        let viewModel = Title(id: titles[indexPath.row].id, originalLanguage: titles[indexPath.row].originalLanguage , originalTitle: titles[indexPath.row].originalTitle, posterPath: titles[indexPath.row].posterPath, overview: titles[indexPath.row].overview, voteCount: titles[indexPath.row].voteCount, releaseDate: titles[indexPath.row].releaseDate, voteAverage: titles[indexPath.row].voteAverage)
        delegate?.collectionViewTableViewCellDelegate(cell: self, viewModel: viewModel)
        print(titles[indexPath.row].id)
    }
}

