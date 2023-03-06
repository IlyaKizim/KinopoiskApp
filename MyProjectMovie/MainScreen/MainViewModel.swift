//
//  MainViewModel.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 16.01.2023.
//

import Foundation

class MainViewModel {
    
    var cellDataSource: Observable<[[Title]]> = Observable(nil)
    var dataSourcePopular: [[Title]] = [[],[],[],[],[]]
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

    func getData() {
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
    
   func getMovies(indexPath: IndexPath, title: [Title]) {
        APICaller.shared.getMovie(with: title[indexPath.row].originalTitle ?? ""  + " trailer") { (results) in
            switch results {
            case .success(let videoElement):
//                print(videoElement.id.videoId)
                MovieDetailsViewControllers.getmodalll(string: videoElement.id.videoId)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
