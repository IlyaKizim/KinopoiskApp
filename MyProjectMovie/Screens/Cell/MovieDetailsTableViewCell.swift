//
//  MovieDetailsTableViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 27.02.2023.
//

import UIKit

protocol MovieDetailsDelegate {
    func presentRate(viewModel: Title)
}

class MovieDetailsTableViewCell: UITableViewCell {
    
    static let identifire = "MovieDetailsTableViewCell"
    var delegate: MovieDetailsDelegate?
    
    private lazy var labelRate: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private lazy var textVote: UITextView = {
        let text = UITextView()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont(name: "Helvetica Neue", size: 18)
        text.backgroundColor = .clear
        text.textAlignment = .center
        text.isScrollEnabled = false
        text.textColor = .gray
        return text
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9986565709, green: 0.3295648098, blue: 0.00157311745, alpha: 1)
        button.layer.cornerRadius = 20
        button.tintColor = .white
        button.setTitle("Оценить", for: .normal)
        button.addTarget(self, action: #selector(getVote), for: .touchUpInside)
        return button
    }()
    
    private lazy var count = 0
    private var titles: Title?
    
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
        contentView.backgroundColor = .black
        contentView.addSubview(labelRate)
        contentView.addSubview(textVote)
        contentView.addSubview(button)
    }
    
    func configure(with label: Double, model: Title){
        self.titles = model
        self.labelRate.textColor = textLabel?.textColor.changeRateColor(with: label)
        self.labelRate.text = String(label)
        self.textVote.text = "\(count) оценок"
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelRate.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelRate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelRate.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            labelRate.heightAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            textVote.topAnchor.constraint(equalTo: labelRate.bottomAnchor, constant: 5),
            textVote.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textVote.trailingAnchor.constraint(equalTo: trailingAnchor),
            textVote.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textVote.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func getVote() {
        guard let title = titles else {return}
        delegate?.presentRate(viewModel: title)
    }
}
// сделал расширение, чтобы не повторять код для смены цвета в зависимости от VoteAverage
extension UIColor {
    func changeRateColor(with model: Double) -> UIColor {
        switch model {
        case 0.0...6.0: return #colorLiteral(red: 0.9706248641, green: 0.3683738112, blue: 0.04389315099, alpha: 1)
        case 6.1...7.5: return #colorLiteral(red: 0.8082595468, green: 0.9330917001, blue: 0.1435986459, alpha: 1)
        case 7.6...10.0: return #colorLiteral(red: 0.13839674, green: 0.9814166427, blue: 0.03376254439, alpha: 1)
        default:
            return .black
        }
    }
}
