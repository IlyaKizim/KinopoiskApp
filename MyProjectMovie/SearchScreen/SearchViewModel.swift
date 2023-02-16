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
