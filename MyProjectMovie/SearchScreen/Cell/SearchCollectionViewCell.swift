//
//  SearchCollectionViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 23.01.2023.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "SearchCollectionViewCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 140, height: 170)
        view.backgroundColor = .green
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
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
    }
}
