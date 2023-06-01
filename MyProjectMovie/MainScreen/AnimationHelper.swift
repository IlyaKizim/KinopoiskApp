//
//  AnimationHelper.swift
//  MyProjectMovie
//
//  Created by Кизим Илья on 30.05.2023.
//

import UIKit

final class AnimationHelper {
    
    static func animateAddToInteresting(on viewController: MainViewController) {
        UIView.animate(withDuration: 0.3) {
            viewController.constraintButtonAddWidth.constant = viewController.view.bounds.width / 1.5
            viewController.constraintButtonPlayHeight.constant = 0
            viewController.constraintButtonDeleteWidth.constant = 0
            viewController.buttonAddToInteresting.setTitle(NSLocalizedString(Constants.added, comment: ""), for: .normal)
            viewController.buttonAddToInteresting.tintColor = .orange
            viewController.buttonAddToInteresting.titleLabel?.adjustsFontSizeToFitWidth = true
            viewController.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, delay: 2.5, options: [], animations: {
                viewController.buttonAddToInteresting.setTitleColor(.orange, for: .normal)
                viewController.constraintButtonAddWidth.constant = 40
                viewController.constraintButtonDeleteWidth.constant = 40
                viewController.constraintButtonPlayHeight.constant = 40
                viewController.buttonPlay.setTitle("", for: .normal)
                viewController.view.layoutIfNeeded()
            }, completion: { _ in
                viewController.buttonPlay.setTitle(NSLocalizedString(Constants.watch, comment: ""), for: .normal)
                viewController.buttonAddToInteresting.setTitle("", for: .normal)
                viewController.view.layoutIfNeeded()
            })
        }
    }
    
    static func animateRemoveFromInteresting(on viewController: MainViewController) {
        UIView.animate(withDuration: 0.3) {
            viewController.buttonAddToInteresting.tintColor = .white
        }
    }
    
    static func animateDeleteFromInteresting(on viewController: MainViewController) {
        UIView.animate(withDuration: 0.3) {
            viewController.constraintButtonDeleteWidth.constant = (viewController.view.bounds.width / 1.5) + 40
            viewController.constraintButtonPlayHeight.constant = 0
            viewController.constraintButtonAddHeight.constant = 0
            viewController.buttonDeleteFromInteresting.setTitle(NSLocalizedString(Constants.notInteresting, comment: ""), for: .normal)
            viewController.buttonDeleteFromInteresting.tintColor = .orange
            viewController.buttonDeleteFromInteresting.titleLabel?.adjustsFontSizeToFitWidth = true
            viewController.view.layoutIfNeeded()
            
            UIView.animate(withDuration: 0.3, delay: 2.5, options: [], animations: {
                viewController.buttonDeleteFromInteresting.setTitleColor(.orange, for: .normal)
                viewController.constraintButtonDeleteWidth.constant = 40
                viewController.constraintButtonPlayHeight.constant = 40
                viewController.constraintButtonAddHeight.constant = 40
                viewController.buttonPlay.setTitle("", for: .normal)
                viewController.view.layoutIfNeeded()
            }, completion: { _ in
                viewController.buttonPlay.setTitle(NSLocalizedString(Constants.watch, comment: ""), for: .normal)
                viewController.buttonDeleteFromInteresting.setImage(UIImage(systemName: SystemName.minus.rawValue), for: .normal)
                viewController.buttonDeleteFromInteresting.setTitle("", for: .normal)
                viewController.view.layoutIfNeeded()
            })
        }
    }
    
    static func animateDeleteRemoveFromInteresting(on viewController: MainViewController) {
        UIView.animate(withDuration: 0.3) {
            viewController.buttonDeleteFromInteresting.tintColor = .white
        }
    }
}
