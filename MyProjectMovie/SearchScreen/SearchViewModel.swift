//
//  SearchViewModel.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 06.02.2023.
//

import Foundation

class SearchViewModel {
    
    let array = ["Категории", "Популярные персоны", "Родились сегодня"]
    let searchPlaceholder = "Фильмы, персоны, кинотеатры"
    
    var cellDataSource: Observable<[People]> = Observable(nil)
    var dataSourcePopular: [People] = []
    
    func heightForRowAt(indexPath: IndexPath) -> Int {
        switch indexPath.section {
        case 0: return 220
        case 1: return 200
        case 2: return 200
        default:
            return 100
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func heightForHeaderInSection() -> Int {
        return 40
    }
    
    func getData() {
        APICaller.shared.getPopularPeople { result in
            switch result {
            case .success(let data):
                self.dataSourcePopular = data
                self.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSourcePopular
    }
}
