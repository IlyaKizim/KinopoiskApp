//
//  SearchCollectionViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 23.01.2023.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "SearchCollectionViewCell"
    private var id: Int?
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 140, height: 170)
    
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.frame = CGRect(x: 0, y: 170, width: 140, height: 30)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = conteinerView.bounds
    }
    
    private func addSubviews() {
        contentView.addSubview(conteinerView)
        contentView.addSubview(label)
        conteinerView.addSubview(posterImageView)
    }
    
    public func configure(with model: String, id: Int, title: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        self.id = id
        self.label.text = title
        
    }
}
