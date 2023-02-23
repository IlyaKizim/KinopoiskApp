//
//  TableViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 21.02.2023.
//

import UIKit


class MediaTableViewCell: UITableViewCell {

    static let identifire = "MediaTableViewCell"
    
    private lazy var posterImageView: UIImageView = {
       let image = UIImageView()
//        image.contentMode = .scaleAspectFill
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
        label.font = UIFont(name: "Helvetica Neue", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    private lazy var labelData: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .black
        label.textColor = .gray
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
    }
    
    private func addSubviews(){
        contentView.addSubview(conteinerView)
        contentView.addSubview(labelData)
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
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            titleLabel.heightAnchor.constraint(equalToConstant: 70)
        ])
        NSLayoutConstraint.activate([
            labelData.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            labelData.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 10),
            labelData.widthAnchor.constraint(equalToConstant: 110),
            labelData.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    func configure(with labelData: String, titleLabel: String, posterImageView: String) {
        guard let url = URL(string: posterImageView) else {
            return
        }
        self.posterImageView.kf.setImage(with: url)
        self.labelData.text = labelData
        self.titleLabel.text = titleLabel
    }
}
