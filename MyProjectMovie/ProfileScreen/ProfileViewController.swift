//
//  ProfileViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var viewProfile: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.08233881742, green: 0.08236103505, blue: 0.08233740181, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = UIImage(systemName: "person.fill")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.08233881742, green: 0.08236103505, blue: 0.08233740181, alpha: 1)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(openPlaceholder), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var presentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewForName: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var viewForPassword: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 18
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var textName: UITextView = {
        let text = UITextView()
        text.delegate = self
        text.textColor = .gray
        text.backgroundColor = .black
        text.font = UIFont(name: "Helvetica Neue", size: 18)
        text.layer.cornerRadius = 15
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var textPassword: UITextView = {
        let text = UITextView()
        text.delegate = self
        text.textColor = .gray
        text.backgroundColor = .black
        text.font = UIFont(name: "Helvetica Neue", size: 18)
        text.layer.cornerRadius = 15
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private lazy var buttonLogin: UIButton = {
        let button = UIButton()
        button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        button.setTitle("Залогиниться", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(logIn), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var isAnimated = false
    private lazy var constraintButtonCenterXAnchor: NSLayoutConstraint = NSLayoutConstraint()
    private lazy var constraintButtonLeading: NSLayoutConstraint = NSLayoutConstraint()
    private lazy var constraintButtonTrailing: NSLayoutConstraint = NSLayoutConstraint()
    private lazy var constraintButtonLogHeight: NSLayoutConstraint = NSLayoutConstraint()
    private lazy var constraintPresentViewHeight: NSLayoutConstraint = NSLayoutConstraint()
    private lazy var constraintNameViewHeight: NSLayoutConstraint = NSLayoutConstraint()
    private lazy var constraintPasswordViewHeight: NSLayoutConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewProfile.layer.cornerRadius = viewProfile.bounds.width / 2
    }
    
    private func setUp() {
        view.backgroundColor = .black
        setUpLayoutConstraint()
        addSubviews()
        addConstraints()
        configureNavBar()
    }
    
    private func setUpLayoutConstraint() {
        constraintButtonCenterXAnchor = button.topAnchor.constraint(equalTo: viewProfile.bottomAnchor, constant: 20)
        constraintButtonLeading = button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70)
        constraintButtonTrailing = button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70)
        constraintPresentViewHeight = presentView.heightAnchor.constraint(equalToConstant: 200)
        constraintNameViewHeight = viewForName.heightAnchor.constraint(equalToConstant: 50)
        constraintPasswordViewHeight = viewForPassword.heightAnchor.constraint(equalToConstant: 50)
        constraintButtonLogHeight = buttonLogin.heightAnchor.constraint(equalToConstant: 50)
    }
    
    private func addSubviews() {
        view.addSubview(viewProfile)
        viewProfile.addSubview(imageView)
        view.addSubview(button)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            constraintButtonCenterXAnchor,
            constraintButtonLeading,
            constraintButtonTrailing,
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            viewProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            viewProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewProfile.widthAnchor.constraint(equalToConstant: 120),
            viewProfile.heightAnchor.constraint(equalToConstant: 120)
        ])
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: viewProfile.topAnchor, constant: 25),
            imageView.leadingAnchor.constraint(equalTo: viewProfile.leadingAnchor,constant: 25),
            imageView.trailingAnchor.constraint(equalTo: viewProfile.trailingAnchor, constant: -25),
            imageView.bottomAnchor.constraint(equalTo: viewProfile.bottomAnchor, constant: -25)
        ])
        
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    @objc private func openPlaceholder() {
        
        if !isAnimated {
            UIView.animate(withDuration: 0.1) {
                self.setForAnimate()
            }
            isAnimated = true
        } else {
            UIView.animate(withDuration: 0.1) {
                self.setForRemove()
            }
            isAnimated = false
        }
    }
    
    @objc private func logIn () {
        print("pressed")
    }
    
    private func setForAnimate() {
        self.constraintButtonCenterXAnchor.constant = 290
        self.constraintButtonLeading.constant = 120
        self.constraintButtonTrailing.constant = -120
        self.constraintPresentViewHeight.constant = 200
        self.constraintNameViewHeight.constant = 50
        self.constraintPasswordViewHeight.constant = 50
        self.constraintButtonLogHeight.constant = 50
        self.textName.text = "Введите имя"
        self.textPassword.text = "Введите пароль"
        self.textName.tintColor = .white
        self.textPassword.tintColor = .white
        self.button.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.view.layoutIfNeeded()
        self.button.setTitle("Назад", for: .normal)
        self.buttonLogin.setTitle("Залогиниться", for: .normal)
        self.view.addSubview(self.viewForName)
        self.view.addSubview(self.viewForPassword)
        self.view.addSubview(self.buttonLogin)
        self.view.addSubview(self.presentView)
        self.presentView.addSubview(self.viewForName)
        self.presentView.addSubview(self.viewForPassword)
        self.presentView.addSubview(self.buttonLogin)
        self.viewForName.addSubview(self.textName)
        self.viewForPassword.addSubview(self.textPassword)
        self.addConstraintForText()
    }
    
    private func setForRemove() {
        self.constraintButtonCenterXAnchor.constant = 20
        self.constraintButtonLeading.constant = 70
        self.constraintButtonTrailing.constant = -70
        self.constraintPresentViewHeight.constant = 0
        self.constraintNameViewHeight.constant = 0
        self.constraintPasswordViewHeight.constant = 0
        self.constraintButtonLogHeight.constant = 0
        self.textName.tintColor = .black
        self.textPassword.tintColor = .black
        self.textName.text = ""
        self.textPassword.text = ""
        self.button.backgroundColor = #colorLiteral(red: 0.08233881742, green: 0.08236103505, blue: 0.08233740181, alpha: 1)
        self.view.layoutIfNeeded()
        self.button.setTitle("Войти", for: .normal)
        self.buttonLogin.setTitle("", for: .normal)
    }
    
    private func addConstraintForText() {
        NSLayoutConstraint.activate([
            presentView.topAnchor.constraint(equalTo: viewProfile.bottomAnchor, constant: 80),
            presentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            presentView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -70),
            constraintPresentViewHeight
        ])
        NSLayoutConstraint.activate([
            viewForName.topAnchor.constraint(equalTo: presentView.topAnchor,constant: 10),
            viewForName.leadingAnchor.constraint(equalTo: presentView.leadingAnchor,constant: 10),
            viewForName.trailingAnchor.constraint(equalTo: presentView.trailingAnchor, constant: -10),
            constraintNameViewHeight
        ])
        NSLayoutConstraint.activate([
            viewForPassword.topAnchor.constraint(equalTo: viewForName.bottomAnchor, constant: 10),
            viewForPassword.leadingAnchor.constraint(equalTo: presentView.leadingAnchor, constant: 10),
            viewForPassword.trailingAnchor.constraint(equalTo: presentView.trailingAnchor, constant: -10),
            constraintPasswordViewHeight
        ])
        NSLayoutConstraint.activate([
            buttonLogin.bottomAnchor.constraint(equalTo: presentView.bottomAnchor, constant: -10),
            buttonLogin.leadingAnchor.constraint(equalTo: presentView.leadingAnchor, constant: 10),
            buttonLogin.trailingAnchor.constraint(equalTo: presentView.trailingAnchor, constant: -10),
            constraintButtonLogHeight
        ])
        NSLayoutConstraint.activate([
            textName.topAnchor.constraint(equalTo: viewForName.topAnchor, constant: 5),
            textName.leadingAnchor.constraint(equalTo: viewForName.leadingAnchor, constant: 5),
            textName.trailingAnchor.constraint(equalTo: viewForName.trailingAnchor, constant: -5),
            textName.heightAnchor.constraint(equalToConstant: 40)
        ])
        NSLayoutConstraint.activate([
            textPassword.topAnchor.constraint(equalTo: viewForPassword.topAnchor, constant: 5),
            textPassword.leadingAnchor.constraint(equalTo: viewForPassword.leadingAnchor, constant: 5),
            textPassword.trailingAnchor.constraint(equalTo: viewForPassword.trailingAnchor, constant: -5),
            textPassword.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension ProfileViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textName.text == "Введите имя" {
            textName.text = ""
            textName.textColor = .gray
        }
        if textPassword.text == "Введите пароль" {
            textPassword.text = ""
            textPassword.textColor = .gray
        }
        
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textName.text == "" {
            textName.text = "Введите имя"
            textName.textColor = .gray
        }
        if textPassword.text == "" {
            textPassword.text = "Введите пароль"
            textPassword.textColor = .gray
        }
    }
}
