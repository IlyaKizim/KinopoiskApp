import UIKit

class MyTableViewCell: UITableViewCell {
    
    static let identifire = "MyTableViewCall"
    
    private lazy var conteinerView: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.08233881742, green: 0.08236103505, blue: 0.08233740181, alpha: 1)
        return view
    }()
    
    private lazy var button: UIButton = {
       let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        button.setTitle("Выбрать, что загрузить", for: .normal)
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textView: UITextView = {
        let text = UITextView()
        text.backgroundColor = #colorLiteral(red: 0.08233881742, green: 0.08236103505, blue: 0.08233740181, alpha: 1)
        text.text = "Загружайте фильмы и сериалы, чтобы смотреть их без интернета"
        text.textColor = .white
        text.font = UIFont(name: "HelveticaNeue", size: 15)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var posterImageView: UIImageView = {
        var image = UIImageView(image: UIImage(systemName: "arrow.down.to.line"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = .gray
        return image
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
        addConstraints()
    }
    
    private func addSubviews() {
        contentView.addSubview(conteinerView)
        conteinerView.addSubview(posterImageView)
        conteinerView.addSubview(textView)
        conteinerView.addSubview(button)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            conteinerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            conteinerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            conteinerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 10),
            posterImageView.centerXAnchor.constraint(equalTo: conteinerView.centerXAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: 50),
            posterImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            textView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 60),
            textView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -60),
            textView.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textView.bottomAnchor,constant: 10),
            button.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 75),
            button.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -75),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
