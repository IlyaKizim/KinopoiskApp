//
//  CellFactory.swift
//  MyProjectMovie
//
//  Created by Кизим Илья on 30.05.2023.
//

import UIKit

final class CellFactory {
    
    static func collectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.identifire)
        collectionView.backgroundColor = .black
        return collectionView
    }
    
    static func posterImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    static func conteinerView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    static func label() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .black
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    static func labelForRate() -> UILabel {
        let label = UILabel()
        label.backgroundColor = .green
        label.tintColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
}
