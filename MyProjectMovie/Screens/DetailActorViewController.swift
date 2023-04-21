import UIKit

class DetailActorViewController: UIViewController {
    
   private lazy var labelName: UILabel = {
       let label = UILabel()
        label.textColor = .gray
        label.text = "Имя"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelDayOfBirthday: UILabel = {
        let label = UILabel()
         label.textColor = .gray
         label.text = "Дата рождения"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private lazy var labelDayOfDeath: UILabel = {
        let label = UILabel()
         label.textColor = .gray
         label.text = "Дата смерти"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private lazy var labelPlaceOfBirth: UILabel = {
        let label = UILabel()
         label.textColor = .gray
         label.text = "Место рождения"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private lazy var labelBiography: UILabel = {
        let label = UILabel()
         label.textColor = .gray
         label.text = "Биография"
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    private lazy var textFieldName: UITextView = {
        let text = UITextView()
        text.backgroundColor = .black
        text.textColor = .white
        text.font = UIFont(name: "Helvetica Neue", size: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
       return text
    }()
    
    private lazy var textFieldDayOfBirthday: UITextView = {
        let text = UITextView()
        text.backgroundColor = .black
        text.textColor = .white
        text.font = UIFont(name: "Helvetica Neue", size: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
       return text
    }()
    
    private lazy var textFieldDayOfDeath: UITextView = {
        let text = UITextView()
        text.backgroundColor = .black
        text.textColor = .white
        text.font = UIFont(name: "Helvetica Neue", size: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
       return text
    }()
    
    private lazy var textFieldPlaceOfBirth: UITextView = {
        let text = UITextView()
        text.backgroundColor = .black
        text.textColor = .white
        text.isScrollEnabled = false
        text.font = UIFont(name: "Helvetica Neue", size: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
       return text
    }()
    
    private lazy var textFieldBiography: UITextView = {
        let text = UITextView()
        text.backgroundColor = .black
        text.textColor = .white
        text.font = UIFont(name: "Helvetica Neue", size: 18)
        text.translatesAutoresizingMaskIntoConstraints = false
       return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setUp()
    }
    
    private func setUp() {
        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(labelName)
        view.addSubview(labelDayOfBirthday)
        view.addSubview(labelDayOfDeath)
        view.addSubview(labelPlaceOfBirth)
        view.addSubview(labelBiography)
        view.addSubview(textFieldName)
        view.addSubview(textFieldDayOfBirthday)
        view.addSubview(textFieldDayOfDeath)
        view.addSubview(textFieldPlaceOfBirth)
        view.addSubview(textFieldBiography)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            labelName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labelName.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            labelName.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            labelDayOfBirthday.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 40),
            labelDayOfBirthday.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labelDayOfBirthday.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            labelDayOfBirthday.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            labelDayOfDeath.topAnchor.constraint(equalTo: labelDayOfBirthday.bottomAnchor, constant: 40),
            labelDayOfDeath.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labelDayOfDeath.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            labelDayOfDeath.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            labelPlaceOfBirth.topAnchor.constraint(equalTo: labelDayOfDeath.bottomAnchor, constant: 40),
            labelPlaceOfBirth.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labelPlaceOfBirth.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            labelPlaceOfBirth.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            labelBiography.topAnchor.constraint(equalTo: labelPlaceOfBirth.bottomAnchor, constant: 40),
            labelBiography.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            labelBiography.trailingAnchor.constraint(equalTo: view.centerXAnchor),
            labelBiography.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            textFieldName.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            textFieldName.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldName.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldName.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            textFieldDayOfBirthday.topAnchor.constraint(equalTo: textFieldName.bottomAnchor, constant: 40),
            textFieldDayOfBirthday.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldDayOfBirthday.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldDayOfBirthday.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            textFieldDayOfDeath.topAnchor.constraint(equalTo: textFieldDayOfBirthday.bottomAnchor, constant: 40),
            textFieldDayOfDeath.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldDayOfDeath.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldDayOfDeath.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            textFieldPlaceOfBirth.topAnchor.constraint(equalTo: textFieldDayOfDeath.bottomAnchor, constant: 40),
            textFieldPlaceOfBirth.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldPlaceOfBirth.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldPlaceOfBirth.heightAnchor.constraint(equalToConstant: 60)
        ])
        NSLayoutConstraint.activate([
            textFieldBiography.topAnchor.constraint(equalTo: textFieldPlaceOfBirth.bottomAnchor, constant: 40),
            textFieldBiography.leadingAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldBiography.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textFieldBiography.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configure(with model: DetailActor) {
        textFieldName.text = model.name
        guard let text = model.name else {return}
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "О персоне \(text)", style: .done, target: nil, action: nil)
        textFieldDayOfBirthday.text = model.birthday
        textFieldDayOfDeath.text = model.deathday ?? "-"
        textFieldPlaceOfBirth.text = model.placeOfBirth
        textFieldBiography.text = model.biography
    }
}

