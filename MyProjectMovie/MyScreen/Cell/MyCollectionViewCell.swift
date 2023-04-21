import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "MyCollectionViewCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = #colorLiteral(red: 0.08233881742, green: 0.08236103505, blue: 0.08233740181, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.08233881742, green: 0.08236103505, blue: 0.08233740181, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        label.textColor = .white
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
    
    private func setUp() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(posterImageView)
        contentView.addSubview(label)
    }

    private func setConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.widthAnchor.constraint(equalToConstant: 180),
            conteinerView.heightAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 30),
            posterImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor,constant: 30),
            posterImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor,constant: -30),
            posterImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor,constant: -30)
        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: conteinerView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configure(with label: String, image: String) {
        self.label.text = label
        let image = UIImage(systemName: image)
        posterImageView.tintColor = #colorLiteral(red: 0.7571807504, green: 0.9420633912, blue: 0.9317061901, alpha: 1)
        self.posterImageView.image = image
    }
}
