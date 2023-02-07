//
//  CategotyCollectionViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 23.01.2023.
//

import UIKit

class CategotyCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "CategotyCollectionViewCell"
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        view.backgroundColor = #colorLiteral(red: 0.1489986479, green: 0.1490316391, blue: 0.1489965916, alpha: 1)
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.frame.size = CGSize(width: 80, height: 40)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.center = conteinerView.center
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        conteinerView.frame = contentView.bounds
        conteinerView.layer.cornerRadius = 15
    }
    
    func configureTextLabel(with string: String) {
        self.label.text = string
    }
    
    private func addSubviews() {
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(label)
    }
}
