//
//  MainViewModel.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 16.01.2023.
//

import Foundation


class MainViewModel {
    
    var cellDataSource: Observable<[Title]> = Observable(nil)
    var dataSourcePopular: TitleMovie?
    var dataSourcePopular2: TitleMovie?
    
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
                self?.dataSourcePopular?.results = data
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    func mapCellData() {
        self.cellDataSource.value = self.dataSourcePopular?.results
    }
    
    
    func getPopularMovie (cell: CollectionViewTableViewCell) {
        APICaller.shared.getPopularMovies { (result) in
            switch result {
            case .success(let titles):
                cell.configure(with: titles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTopRateMovie(cell: CollectionViewTableViewCell) {
        APICaller.shared.getTopRateMovie { (result) in
            switch result {
            case .success(let titles):
                cell.configure(with: titles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getUpcomingMovie(cell: CollectionViewTableViewCell) {
        APICaller.shared.getUpComingMovies { (result) in
            switch result {
            case .success(let titles):
                cell.configure(with: titles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getPlayingNowMoview(cell: CollectionViewTableViewCell) {
        APICaller.shared.getPlayingNowMoview { (result) in
            switch result {
            case .success(let titles):
                cell.configure(with: titles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getTVshow(cell: CollectionViewTableViewCell) {
        APICaller.shared.getTVshow { (result) in
            switch result {
            case .success(let titles):
                cell.configure(with: titles)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
   func getMovies(indexPath: IndexPath, title: [Title]) {
        APICaller.shared.getMovie(with: title[indexPath.row].originalTitle ?? ""  + " trailer") { (results) in
            switch results {
            case .success(let videoElement):
                print(videoElement.id.videoId)
                MovieDetailsViewControllers.getmodalll(string: videoElement.id.videoId)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
