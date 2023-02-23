//
//  TitleCollectionViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 12.01.2023.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "TitleCollectionViewCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelForRate: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        contentView.addSubview(conteinerView)
        contentView.addSubview(label)
        contentView.addSubview(labelForRate)
        conteinerView.addSubview(posterImageView)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.widthAnchor.constraint(equalToConstant: 140),
            conteinerView.heightAnchor.constraint(equalToConstant: 170)
        ])
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: conteinerView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            labelForRate.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelForRate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelForRate.widthAnchor.constraint(equalToConstant: 25),
            labelForRate.heightAnchor.constraint(equalToConstant: 25)
        ])
    }

    public func configures(with oneModel: String, with twoModel: Double, with threeModel: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(oneModel)") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        
        switch twoModel {
        case 0.0...6.0: labelForRate.backgroundColor = #colorLiteral(red: 0.9706248641, green: 0.3683738112, blue: 0.04389315099, alpha: 1)
        case 6.1...7.5: labelForRate.backgroundColor = #colorLiteral(red: 0.8082595468, green: 0.9330917001, blue: 0.1435986459, alpha: 1)
        case 7.6...10.0: labelForRate.backgroundColor = #colorLiteral(red: 0.13839674, green: 0.9814166427, blue: 0.03376254439, alpha: 1)
        default:
            break
        }
        labelForRate.text = String(twoModel)
        
        label.text = threeModel
    }
} 
