//
//  MyTableViewCellPackages.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 02.04.2023.
//

import UIKit

class MyTableViewCellPackages: UITableViewCell {
    
    static let identifire = "MyTableViewCellPackages"
    
    private lazy var posterImageView: UIImageView = {
       let image = UIImageView()
        image.backgroundColor = .gray
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UITextView = {
       let label = UITextView()
        label.isScrollEnabled = false
        label.font = UIFont(name: "Helvetica Neue", size: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    private lazy var labelRate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.textColor = .white
        label.textAlignment = .center
        return label
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
        addConstraints()
        labelRate.layer.cornerRadius = 20
        labelRate.layer.masksToBounds = true
    }
    
    private func addSubviews(){
        contentView.addSubview(conteinerView)
        contentView.addSubview(labelRate)
        contentView.addSubview(titleLabel)
        conteinerView.addSubview(posterImageView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            conteinerView.widthAnchor.constraint(equalToConstant: 80),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            labelRate.heightAnchor.constraint(equalToConstant: 40),
            labelRate.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 25),
            labelRate.widthAnchor.constraint(equalToConstant: 40),
            labelRate.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    func configuration(with model: RateMovie) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterPath ?? "")") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        titleLabel.text = model.originalTitle
        labelRate.text = String(model.rate)
    }
}
