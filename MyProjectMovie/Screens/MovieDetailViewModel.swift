//
//  MovieDetailViewModel.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 27.02.2023.
//

import Foundation

class MovieDetailViewModel {
    let arrayTitle = ["Рейтинг Кинопоиска", "Актеры"]
    var cellDataSource: Observable<[ActrosWhoPlaying]> = Observable(nil)
    var dataSourceActors: [ActrosWhoPlaying] = []
    

    func heightForRow (indexPath: IndexPath) -> Int {
        switch indexPath.section {
        case 0: return 200
        case 1: return 300
        default:
            return 10
        }
    }
    
    func numberOfRowsInSection() -> Int {
        1
    }
    
    func getData(query: String) {
        APICaller.shared.getActorsWhoPlayingInMovie(with: query) { (result) in
            switch result {
            case .success(let results):
                self.dataSourceActors = results
                self.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSourceActors
    }
    
    func getDataForDetail(with vc: DetailActorsViewController, viewModel: ActrosWhoPlaying) {
       
        vc.setUpForAnotherWay(with: viewModel)
        vc.navigationItem.leftBarButtonItem?.tintColor = .white
        guard let id = viewModel.id else {return}
        APICaller.shared.getDetailActor(with: String(id)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    DetailActorsViewController.detail = titles
                    vc.configureLabel(with: titles)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        APICaller.shared.getListMoviesForActors(with: String(id)) { (result) in
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
}
