//
//  PresentPlayViewModel.swift
//  MyProjectMovie
//
//  Created by Кизим Илья on 27.05.2023.
//

import Foundation

class PresentPlayViewModel {
    
    private var apiclientGetMovie: ApiclientGetMovie
    
    init(apiclientGetMovie: ApiclientGetMovie) {
        self.apiclientGetMovie = apiclientGetMovie
    }
    
    func getMovies(string: String) {
        apiclientGetMovie.getMovie(with: string  + " trailer") { (results) in
            switch results {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    VideoId.id = videoElement.id.videoId
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
