//
//  MovieDetailsActorsCellTableView.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 03.03.2023.
//

import UIKit

protocol CollectionViewCellDelegate: AnyObject {
    func CollectionViewCellDelegate(viewModel: ActrosWhoPlaying)
}

class MovieDetailsActorsCellTableView: UITableViewCell {
    
    static let identifire = "MovieDetailsActorsCellTableView"
    private var cast: [ActrosWhoPlaying] = [ActrosWhoPlaying]()
    private let movieDetailViewModel = MovieDetailViewModel()
    weak var delegate: CollectionViewCellDelegate?
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 80)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ActrorsWhoPlayingCollectionViewCell.self, forCellWithReuseIdentifier: ActrorsWhoPlayingCollectionViewCell.identifire)
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
        contentView.backgroundColor = .black
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    public func configure(with cast: [ActrosWhoPlaying]) {
        self.cast = cast
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
            
        }
    }
}

extension MovieDetailsActorsCellTableView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ActrorsWhoPlayingCollectionViewCell.identifire, for: indexPath) as? ActrorsWhoPlayingCollectionViewCell else {return UICollectionViewCell()}
        let model = cast[indexPath.row]
        let poster = model.profilePath ?? ""
        let label = model.originalName ?? ""
        cell.configure(with: poster, label: label)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = ActrosWhoPlaying(originalName: cast[indexPath.row].originalName, profilePath: cast[indexPath.row].profilePath, id: cast[indexPath.row].id)
        delegate?.CollectionViewCellDelegate(viewModel: viewModel)
    }
    
    
}
