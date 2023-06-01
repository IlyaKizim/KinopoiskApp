//
//  PresentPlayViewModel.swift
//  MyProjectMovie
//
//  Created by Кизим Илья on 27.05.2023.
//

import Foundation
import RxSwift

class PresentPlayViewModel {
    
    private var apiclientGetMovie: Apiclient
    lazy var disposeBag = DisposeBag()
    
    init(apiclientGetMovie: Apiclient) {
        self.apiclientGetMovie = apiclientGetMovie
    }
    
    func getMovie(string: String) {
        apiclientGetMovie.getMovie(with: string + " trailer")
            .observe(on: MainScheduler.instance)
            .subscribe { event in
                
                switch event {
                case .next(let videoElement):
                    VideoId.id = videoElement.id.videoId
                    print(VideoId.id )
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    // Handle completion if needed
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}
