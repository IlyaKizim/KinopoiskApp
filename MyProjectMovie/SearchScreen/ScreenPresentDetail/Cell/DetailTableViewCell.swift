//
//  DetailTableViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 15.02.2023.
//

import UIKit
import Kingfisher


class DetailTableViewCell: UITableViewCell {

    
    static let identifire = "DetailTableViewCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var label: UILabel =  {
        let label = UILabel()
        label.textColor = .white
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdentifiers: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifiers)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = conteinerView.bounds
    }

    private func setUpView() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(label)
        conteinerView.addSubview(posterImageView)
        contentView.addSubview(conteinerView)
        
        
    }
    private func setConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            conteinerView.widthAnchor.constraint(equalToConstant: 80),
            conteinerView.heightAnchor.constraint(equalToConstant: 100)
        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    func configuration(with model: String, twoModel: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        self.label.text = twoModel
        
    }
}
