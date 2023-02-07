//
//  RxTableViewCell.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 16.01.2023.
//

import UIKit

class RxTableViewCell: UITableViewCell {
    
    static let identifire = "RxTableViewCell"
    
    func configure (with string: String) {
        textLabel?.text = string
    }
}
