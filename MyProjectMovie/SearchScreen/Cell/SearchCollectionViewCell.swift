import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "SearchCollectionViewCell"
    private var id: Int?
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
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
        contentView.addSubview(label)
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
            label.widthAnchor.constraint(equalToConstant: 140),
            label.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    func configuration(with model: People) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.profilePath ?? "")") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        self.id = model.id
        self.label.text = model.name ?? ""
    }
}
