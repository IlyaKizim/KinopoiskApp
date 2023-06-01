//
//  ViewFactory.swift
//  MyProjectMovie
//
//  Created by Кизим Илья on 30.05.2023.
//

import UIKit

final class ViewFactory {
    
    static func createHeaderView() -> UIView {
        let headerView = UIView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        return headerView
    }
    
    static func createHeaderImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    static func createHeaderLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .center
        label.backgroundColor = .black
        label.font = UIFont(name: Font.helveticaBold.rawValue, size: 20)
        return label
    }
    
    static func createHeaderOverView() -> UITextView {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .black
        textView.textColor = .white
        return textView
    }
    
    static func createTableView() -> UITableView {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifire)
        tableView.backgroundColor = .black
        return tableView
    }
    
    static func createButtonDeleteFromInteresting(target: Any, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setImage(UIImage(systemName: SystemName.minus.rawValue), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = .white
        return button
    }
    
    static func createButtonPlay(target: Any, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9986565709, green: 0.3295648098, blue: 0.00157311745, alpha: 1)
        button.setImage(UIImage(systemName: SystemName.play.rawValue), for: .normal)
        button.tintColor = .white
        button.setTitle(NSLocalizedString(Constants.watch, comment: ""), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    static func createButtonAddToInteresting(target: Any, action: Selector) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.setImage(UIImage(systemName: SystemName.addInteresting.rawValue), for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.tintColor = .white
        return button
    }
}
