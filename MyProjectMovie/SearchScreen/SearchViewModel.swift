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
    
    func getDetailAndMovieActors(with string: String, vc: DetailActorsViewController) {
        APICaller.shared.getDetailActor(with: string) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    vc.detail = titles
                    vc.configureLabel(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        APICaller.shared.getListMoviesForActors(with: string) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    vc.configureTableView(with: result)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getSearch(with query: String, resultController: SearchResultsControllerViewController) {
        APICaller.shared.search(with: query ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultController.titles = titles
                    resultController.tableViewForSearch.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
