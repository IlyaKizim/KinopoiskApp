//
//  SearchTableViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 23.01.2023.
//

import UIKit

protocol TableViewCellDelegate: AnyObject {
    func tableViewCellDelegate(cell: SearchTableViewCell, viewModel: People)
}

class SearchTableViewCell: UITableViewCell {
    
    weak var delegate: TableViewCellDelegate?
    static let identifire = "SearchTableViewCell"
    private var titles: [People] = [People]()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.identifire)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdentifiers: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifiers)
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
    
    public func configure(with titles: [People]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
        }
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
        guard let model = titles[indexPath.row].profilePath else {return UICollectionViewCell()}
        guard let title = titles[indexPath.row].name else {return UICollectionViewCell()}
        guard let id = titles[indexPath.row].id else {return UICollectionViewCell()}
        
        cell.configure(with: model, id: id, title: title)
       
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
        let viewModel = People(id: titles[indexPath.row].id, name: titles[indexPath.row].name, profilePath: titles[indexPath.row].profilePath)
        delegate?.tableViewCellDelegate(cell: self, viewModel: viewModel)
    }
}

