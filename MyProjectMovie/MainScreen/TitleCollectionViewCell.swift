import UIKit

final class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "TitleCollectionViewCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelForRate: UILabel = {
        let label = UILabel()
        label.backgroundColor = .green
        label.tintColor = .black
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
        contentView.addSubview(label)
        contentView.addSubview(labelForRate)
        conteinerView.addSubview(posterImageView)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conteinerView.widthAnchor.constraint(equalToConstant: 140),
            conteinerView.heightAnchor.constraint(equalToConstant: 170)
        ])
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: conteinerView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            labelForRate.topAnchor.constraint(equalTo: contentView.topAnchor),
            labelForRate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            labelForRate.widthAnchor.constraint(equalToConstant: 25),
            labelForRate.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
    func configuration(with model: Title) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.posterPath ?? "")") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        labelForRate.backgroundColor = label.backgroundColor?.changeRateColor(with: model.voteAverage ?? 0.0)
        labelForRate.text = String(model.voteAverage ?? 0.0)
        label.text = model.originalTitle ?? ""
    }
}
