//
//  SearchresultTableViewTableViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 03.02.2023.
//

import UIKit

class SearchresultTableViewTableViewCell: UITableViewCell {
    
    static let identifire = "SearchresultTableViewTableViewCell"
   
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
    
    private lazy var label: UILabel =  {
        let label = UILabel()
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelRate: UILabel = {
       let labelRate = UILabel()
        labelRate.translatesAutoresizingMaskIntoConstraints = false
        labelRate.backgroundColor = .black
        return labelRate
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
        contentView.addSubview(label)
        contentView.addSubview(labelRate)
        conteinerView.addSubview(posterImageView)
        contentView.addSubview(conteinerView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            conteinerView.heightAnchor.constraint(equalToConstant: 60),
            conteinerView.widthAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: 10),
            label.widthAnchor.constraint(equalToConstant: contentView.bounds.width - 20),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            labelRate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            labelRate.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
            labelRate.widthAnchor.constraint(equalToConstant: 40),
            labelRate.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configuration(with model: Title) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterPath ?? "")") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        label.textColor = .white
        self.label.text = model.originalTitle ?? ""
        labelRate.textColor = .white
        labelRate.textColor = label.textColor.changeRateColor(with: model.voteAverage ?? 0.0)
        let array = Array(String(model.voteAverage ?? 0.0)) // у меня приходит voteAverage с 4-5 цифрами после точки, поэтому пришлось через цикл делать чтобы только 2 числа было. Можно было конечно череp .map ну может позже вернусь сделаю
        var newArray: [Character] = [Character]()
        for i in 0...2 {
            newArray.append(array[i])
        }
        let rate = String(newArray)
        self.labelRate.text = String(rate)
    }
}
