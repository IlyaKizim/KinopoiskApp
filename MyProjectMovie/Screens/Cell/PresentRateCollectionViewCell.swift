//
//  PresentRateCollectionViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 27.02.2023.


import UIKit

class PresentRateCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "PresentRateCollectionViewCell"
    
     var conteinerView: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.textAlignment = .center
        view.font = UIFont(name: "HelveticaNeue-Bold", size: 55)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with string: String) {
        self.conteinerView.text = string
    }
    
    func configureColor(with string: UIColor) {
        self.conteinerView.textColor = string
    }
}
