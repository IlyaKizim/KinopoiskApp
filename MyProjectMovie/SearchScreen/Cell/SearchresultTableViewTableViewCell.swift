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

    func configures(with oneModel: String, with twoModel: String, with threeModel: Double) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(oneModel)") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        
        label.textColor = .white
        self.label.text = twoModel
        
        labelRate.textColor = .white
        switch threeModel {
        case 0...6: labelRate.textColor = #colorLiteral(red: 0.9706248641, green: 0.3683738112, blue: 0.04389315099, alpha: 1)
        case 6.1...7.5: labelRate.textColor = #colorLiteral(red: 0.8082595468, green: 0.9330917001, blue: 0.1435986459, alpha: 1)
        case 7.6...10: labelRate.textColor = #colorLiteral(red: 0.13839674, green: 0.9814166427, blue: 0.03376254439, alpha: 1)
        default:
            break
        }
        
        let array = Array(String(threeModel))
        var newArray: [Character] = [Character]()
        for i in 0...2 {
            newArray.append(array[i])
        }
        let rate = String(newArray)
        self.labelRate.text = String(rate)
    }
}
