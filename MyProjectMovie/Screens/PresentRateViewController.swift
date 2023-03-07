//
//  PresentRateViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 27.02.2023.
//

import UIKit

final class PresentRateViewController: UIViewController {
    
    private lazy var conteinerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "Оценить"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var posterImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private lazy var labelYear: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttomBack: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.tintColor = .white
        button.backgroundColor = .gray
        button.setTitle("Не оценивать", for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonClose: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = view.bounds.width / 2
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PresentRateCollectionViewCell.self, forCellWithReuseIdentifier: PresentRateCollectionViewCell.identifire)
        collectionView.backgroundColor = #colorLiteral(red: 0.1489986479, green: 0.1490316391, blue: 0.1489965916, alpha: 1)
        return collectionView
    }()
    
    private lazy var viewForRate: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.3
        return view
    }()
    
    private lazy var presentRateViewModel = PresentRateViewModel()
    private lazy var flag = true
    var centerIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        viewForRate.layer.cornerRadius = viewForRate.bounds.width / 2
    }
    
    private func setUp() {
        view.backgroundColor = #colorLiteral(red: 0.1489986479, green: 0.1490316391, blue: 0.1489965916, alpha: 1)
        addSubViews()
        addConstraints()
    }
    
    private func addSubViews() {
        view.addSubview(conteinerView)
        view.addSubview(label)
        conteinerView.addSubview(posterImageView)
        view.addSubview(nameLabel)
        view.addSubview(labelYear)
        view.addSubview(buttomBack)
        view.addSubview(buttonClose)
        view.addSubview(collectionView)
        collectionView.addSubview(viewForRate)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 180),
            label.heightAnchor.constraint(equalToConstant: 80)
        ])
        NSLayoutConstraint.activate([
            conteinerView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            conteinerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            conteinerView.widthAnchor.constraint(equalToConstant: 160),
            conteinerView.heightAnchor.constraint(equalToConstant: 220)
        ])
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: conteinerView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: 10),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 250),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            labelYear.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            labelYear.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelYear.widthAnchor.constraint(equalToConstant: 100),
            labelYear.heightAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            buttomBack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            buttomBack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttomBack.widthAnchor.constraint(equalToConstant: 200),
            buttomBack.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            buttonClose.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            buttonClose.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            buttonClose.widthAnchor.constraint(equalToConstant: 30),
            buttonClose.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: labelYear.bottomAnchor, constant: 100),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        NSLayoutConstraint.activate([
            viewForRate.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor),
            viewForRate.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            viewForRate.heightAnchor.constraint(equalToConstant: 110),
            viewForRate.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    func setUps(with set: Title) {
        guard let string = set.posterPath else {return}
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(string)") else {
            return
        }
        posterImageView.kf.setImage(with: url)
        guard let nameText = set.originalTitle else {return}
        guard let textYear = set.releaseDate else {return}
        nameLabel.text = nameText
        let array = Array(textYear)
        var newArray:[Character] = [Character]()
        for i in 0...3 {
            newArray.append(array[i])
        }
        let label = String(newArray)
        labelYear.text = label
    }
    
    @objc private func back () {
        if flag == true {
            dismiss(animated: true, completion: nil)
        } else {
            print("оценить")
        }
    }
    
    @objc private func close () {
        dismiss(animated: true, completion: nil)
    }
}

extension PresentRateViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presentRateViewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PresentRateCollectionViewCell.identifire, for: indexPath) as? PresentRateCollectionViewCell else {return UICollectionViewCell()}
        let text = presentRateViewModel.array[indexPath.row]
        cell.configure(with: text)
        // это для того, чтобы менялся цвет цифрт при выборе рейтинга
        if indexPath == centerIndexPath {
            cell.configureColor(with: self.buttomBack.backgroundColor ?? .white)
            reloadData()
        } else {
            cell.configureColor(with: .white)
            reloadData()
        }
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.showsHorizontalScrollIndicator = false
        let center = CGPoint(x: scrollView.contentOffset.x + scrollView.frame.width / 2, y: scrollView.frame.height / 2)
        if let centerIndexPath = collectionView.indexPathForItem(at: center) {
            self.centerIndexPath = centerIndexPath
            collectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let center = view.bounds.width / 2
        return UIEdgeInsets(top: 0, left: center - 50, bottom: 0, right: center - 50)
    }
    // это чтобы при скролле останавливалось на каждой цифре и не прокручивалось дальше
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        targetContentOffset.pointee = scrollView.contentOffset
        let factor: CGFloat = 0.5
        let indexPath = IndexPath(row: Int((scrollView.contentOffset.x/100 + factor)), section: 0)
        if indexPath.row < 11 {
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        switch indexPath.row {
        case 0: self.buttomBack.backgroundColor = .gray
            self.buttomBack.setTitle("Не оценивать", for: .normal)
            self.flag = true
        case 5, 6: self.buttomBack.backgroundColor = .gray
            self.buttomBack.setTitle("Оценить", for: .normal)
            self.flag = false
        case 1...4: self.buttomBack.backgroundColor = .red
            self.buttomBack.setTitle("Оценить", for: .normal)
            self.flag = false
        case 7...10: self.buttomBack.backgroundColor = .green
            self.buttomBack.setTitle("Оценить", for: .normal)
            self.flag = false
        default:
            break
        }
    }
}
