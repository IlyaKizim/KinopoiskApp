//
//  ViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//
import UIKit

class ViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        createTabBar ()
       
    }
    private func createTabBar () {
        let vcOne = UINavigationController(rootViewController: MainViewController())
        let vcTwo = UINavigationController(rootViewController: MediaViewController())
        let vcThree = UINavigationController(rootViewController: MyViewController())
        let vcFour = UINavigationController(rootViewController: SearchViewController())
        let vcFive = UINavigationController(rootViewController: ProfileViewController())
        
        vcOne.tabBarItem.image = UIImage(systemName: "house")
        vcTwo.tabBarItem.image = UIImage(systemName: "video.fill")
        vcThree.tabBarItem.image = UIImage(systemName: "bookmark.fill")
        vcFour.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vcFive.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        
        vcOne.title = "Главная"
        vcTwo.title = "Медиа"
        vcThree.title = "Мое"
        vcFour.title = "Поиск"
        vcFive.title = "Профиль"
        
        tabBar.tintColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        tabBar.backgroundColor = #colorLiteral(red: 0.0898212865, green: 0.1018639281, blue: 0.1102195755, alpha: 1)
        tabBar.barTintColor = #colorLiteral(red: 0.0898212865, green: 0.1018639281, blue: 0.1102195755, alpha: 1)
        
        setViewControllers([vcOne, vcTwo, vcThree, vcFour, vcFive], animated: true)
    }
}
