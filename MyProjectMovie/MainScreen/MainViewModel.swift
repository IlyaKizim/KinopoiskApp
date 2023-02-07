//
//  MainViewModel.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 16.01.2023.
//

import Foundation


class MainViewModel {
    
    let titleForHeaderSection = ["Популярные фильмы", "Высокий рейтинг", "Скоро в прокате", "Смотрят сейчас", "TV шоу"]
    
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
                print("yes")
                MovieDetailsViewControllers.getmodalll(string: videoElement.id.videoId)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
