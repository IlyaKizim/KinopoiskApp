//
//  MyViewModel.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 16.01.2023.


import Foundation

class MyViewModel {
    
    let array = ["Буду смотреть", "Загрузки", "Покупки", "Папки"]
    let title = "МОЁ"
    let imageArray = ["star.circle", "heart.circle", "hand.thumbsup.fill", "folder.fill", "person.circle"]
    let labelArray = ["Оценки и просмотры", "Любимые фильмы", "Рекомендуемые фильмы", "Примечания", "Персоны"]
    let text = "Загружайте фильмы и сериалы, чтобы смотреть их без интернета"
    
    func numberOfRowsInSection () -> Int {
        1
    }
    
    func heightForRow (indexPath: IndexPath) -> Int {
        switch indexPath.section {
        case 0: return 0
        case 1: return 220
        case 2: return 0
        case 3: return 200
        default:
            return 10
        }
    }
    func heightForRowWithCount (indexPath: IndexPath) -> Int {
        switch indexPath.section {
        case 0: return 200
        case 1: return 220
        case 2: return 0
        case 3: return 200
        default:
            return 10
        }
    }
    
    func heightForHeaderInSection() -> Int {
        50
    }
}
