//
//  PresentViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 18.01.2023.
//

import UIKit
import Kingfisher

class MovieDetailsViewControllers: UIViewController {
    
    static var model = ""
    
    private lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    private lazy var buttonPlay: UIButton = {
        let buttonPlay = UIButton()
        buttonPlay.translatesAutoresizingMaskIntoConstraints = false
        buttonPlay.backgroundColor = #colorLiteral(red: 0.9986565709, green: 0.3295648098, blue: 0.00157311745, alpha: 1)
        buttonPlay.layer.cornerRadius = 20
        buttonPlay.setImage(UIImage(systemName: "play.fill"), for: .normal)
        buttonPlay.tintColor = .white
        buttonPlay.setTitle("  Смотреть", for: .normal)
        buttonPlay.addTarget(self, action: #selector(pushToPresent), for: .touchUpInside)
        return buttonPlay
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.backgroundColor = .black
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assSubviews()
        setConstraint()
    }
    
    override func viewDidLayoutSubviews() {
        posterImageView.frame = conteinerView.bounds
    }
    
    private func assSubviews() {
        view.backgroundColor = .black
        setNavBar()
        view.addSubview(titlelabel)
        view.addSubview(buttonPlay)
        view.addSubview(conteinerView)
    }
    
    func setUp(with set: Title) {
        titlelabel.text = set.originalTitle
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(set.posterPath ?? "")") else {
            return
        }
        
        posterImageView.kf.setImage(with: url)
        conteinerView.addSubview(posterImageView)
    }
    
    @objc func pushToPresent() {
        let vc = PresentPlayViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.configure(with: MovieDetailsViewControllers.model)
        print(MovieDetailsViewControllers.model)
        present(vc, animated: true, completion: nil)
    }
    
    static func getmodalll(string: String) {
        MovieDetailsViewControllers.model = string
    }
    
    private func setNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .done, target: self, action: #selector(back))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc func back() {
        navigationController?.popToRootViewController(animated: true)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setConstraint() {
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            conteinerView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            titlelabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
            titlelabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            titlelabel.widthAnchor.constraint(equalToConstant: view.bounds.width),
            titlelabel.heightAnchor.constraint(equalToConstant: 100),
            buttonPlay.topAnchor.constraint(equalTo: titlelabel.bottomAnchor, constant: 0),
            buttonPlay.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            buttonPlay.widthAnchor.constraint(equalToConstant: 150),
            buttonPlay.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

