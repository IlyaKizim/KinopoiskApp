//
//  MainViewModel.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 16.01.2023.
//

import Foundation

class MainViewModel {
    
    enum Section: Int {
        case PopularMovies = 0
        case TopRateMovie
        case UpComingMovies
        case PlayingNowMoview
        case TVshow
    }
    
    var cellDataSource: Observable<[[Title]]> = Observable(nil)
    var dataSourcePopular: [[Title]] = [[],[],[],[],[]] //я честно по другому не придумал как мне разделить данные, полученные из сервера, поэтому вот такой ужас пришел в голову
    let titleForHeaderSection = ["Популярные фильмы", "Высокий рейтинг", "Скоро в прокате", "Смотрят сейчас", "TV шоу"]
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func heightForRowAt() -> Float {
       return 200
    }
    
    func heightForHeaderInSection() -> Float {
        return 40
    }

    func getData() { // все запросы
        APICaller.shared.getPopularMovies {[weak self] result in
            switch result {
            case .success(let data):
                self?.dataSourcePopular[0] = data
                self?.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.getTopRateMovie { (result) in
            switch result {
            case .success(let data):
                self.dataSourcePopular[1] = data
                self.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.getUpComingMovies { (result) in
            switch result {
            case .success(let data):
                self.dataSourcePopular[2] = data
                self.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.getPlayingNowMoview { (result) in
            switch result {
            case .success(let data):
                self.dataSourcePopular[3] = data
                self.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.getTVshow { (result) in
            switch result {
            case .success(let data):
                self.dataSourcePopular[4] = data
                self.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSourcePopular
    }
    // это запрос на получение данные от ютуба для просмотра видео, вместо id использовал поиск по названию + трейлер
   func getMovies(indexPath: IndexPath, title: [Title]) {
        APICaller.shared.getMovie(with: title[indexPath.row].originalTitle ?? ""  + " trailer") { (results) in
            switch results {
            case .success(let videoElement):
                MovieDetailsViewControllers.getmodalll(string: videoElement.id.videoId)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
