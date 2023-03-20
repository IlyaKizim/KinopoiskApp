//
//  CategotyCollectionViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 23.01.2023.


import UIKit

class CategotyCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "CategotyCollectionViewCell"
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1489986479, green: 0.1490316391, blue: 0.1489965916, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        conteinerView.layer.cornerRadius = 15
    }
    
    func configureTextLabel(with string: String) {
        self.label.text = string
        label.setNeedsDisplay()
        label.sizeToFit()
    }
    
    private func setUp() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(label)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.widthAnchor.constraint(equalToConstant: 100),
            conteinerView.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 5),
            label.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -5),
            label.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -5)
        ])
    }
}
