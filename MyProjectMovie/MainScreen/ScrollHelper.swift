//
//  ScrollHelper.swift
//  MyProjectMovie
//
//  Created by Кизим Илья on 30.05.2023.
//

import UIKit

final class ScrollHelper {
    static func updateNavigationBarAppearance(_ contentOffsetY: CGFloat, safeAreaInsetsTop: CGFloat, navigationItem: UINavigationItem, backButtonAction: Selector) {
        if contentOffsetY >= safeAreaInsetsTop + 40 {
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: nil, style: .done, target: nil, action: nil)
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: NSLocalizedString(Constants.main, comment: ""), style: .done, target: self, action: backButtonAction)
            navigationItem.leftBarButtonItem?.tintColor = .white
        } else if contentOffsetY == safeAreaInsetsTop {
            var image = UIImage(named: Constants.logo)
            image = image?.withRenderingMode(.alwaysOriginal)
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: nil, action: nil)
        }
    }
}
