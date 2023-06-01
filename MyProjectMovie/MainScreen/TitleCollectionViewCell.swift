
import UIKit

final class TitleCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    
    static let identifire = "TitleCollectionViewCell"
    private lazy var posterImageView: UIImageView = CellFactory.posterImageView()
    private lazy var conteinerView: UIView = CellFactory.conteinerView()
    private lazy var label: UILabel = CellFactory.label()
    private lazy var labelForRate: UILabel = CellFactory.labelForRate()
    
    //MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TitleCollectionViewCell {
    
    //MARK: - Setup UI
    
    private func setUp() {
        addSubviews()
        setConstraints()
    }
}

extension TitleCollectionViewCell {
    
    //MARK: - AddSubviews
    
    private func addSubviews() {
        contentView.addSubview(conteinerView)
        contentView.addSubview(label)
        contentView.addSubview(labelForRate)
        conteinerView.addSubview(posterImageView)
    }
}

extension TitleCollectionViewCell {
    
    //MARK: - Constraints
    
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
}

extension TitleCollectionViewCell {
    
    //MARK: - Configuration
    
    func configuration(with model: Title) {
        guard let url = URL(string: "\(ConstantsURL.image)\(model.posterPath ?? "")") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        labelForRate.backgroundColor = label.backgroundColor?.changeRateColor(with: model.voteAverage ?? 0.0)
        labelForRate.text = String(model.voteAverage ?? 0.0)
        label.text = model.originalTitle ?? ""
    }
}
