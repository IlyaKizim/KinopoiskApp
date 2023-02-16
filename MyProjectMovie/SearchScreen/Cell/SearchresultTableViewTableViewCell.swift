//
//  SearchresultTableViewTableViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 03.02.2023.
//

import UIKit
import Kingfisher

class SearchresultTableViewTableViewCell: UITableViewCell {
    
    static let identifire = "SearchresultTableViewTableViewCell"
   
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 10, y: 0, width: 50, height: 60)
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var label: UILabel =  {
        let label = UILabel()
        return label
    }()
    
    private lazy var labelRate: UILabel = {
       let labelRate = UILabel()
        return labelRate
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIdentifiers: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifiers)
        addSubviews()
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = conteinerView.bounds
    }
    
    private func setupLabel() {
        label.frame = CGRect(x: 70, y: 15, width: contentView.bounds.width - 20, height: 30)
        label.backgroundColor = .black
        
        labelRate.frame = CGRect(x: label.frame.origin.x + (contentView.bounds.width - 20) + 10, y: 15, width: 40, height: 30)
        labelRate.backgroundColor = .black
    }
    
    private func addSubviews() {
        contentView.addSubview(label)
        contentView.addSubview(labelRate)
        conteinerView.addSubview(posterImageView)
        contentView.addSubview(conteinerView)
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
        self.labelRate.text = String(threeModel)
    }
}
