import Foundation


protocol MainViewModelDelegate: AnyObject {
    func updateData()
}

protocol SetForHeaderDelegate: AnyObject {
    func setUp()
}

class MainViewModel {
    
    enum Section: Int {
        case PopularMovies = 0
        case TopRateMovie
        case UpComingMovies
        case PlayingNowMoview
        case TVshow
    }
    
    enum MovieData {
        case popular([Title])
        case topRated([Title])
        case upcoming([Title])
        case favorites([Title])
        case watched([Title])
    }

    lazy var movieData: [MovieData] = [.popular([]), .topRated([]), .upcoming([]), .favorites([]), .watched([])]
    lazy var integer = 0
    lazy var randomInt = Int.random(in: 0..<integer)
    lazy var radius = 20
    weak var delegate: MainViewModelDelegate?
    weak var headerDelegate: SetForHeaderDelegate?
    lazy var titleForHeaderSection = [
        "Популярные фильмы",
        "Высокий рейтинг",
        "Скоро в прокате",
        "Смотрят сейчас",
        "TV шоу"
    ]
    
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
                DispatchQueue.main.async {
                self?.movieData[0] = .popular(data)
                self?.integer = data.count
                self?.headerDelegate?.setUp()
                self?.delegate?.updateData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.getTopRateMovie {[weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                self?.movieData[1] = .topRated(data)
                self?.delegate?.updateData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.getUpComingMovies {[weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                self?.movieData[2] = .upcoming(data)
                self?.delegate?.updateData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.getPlayingNowMoview {[weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                self?.movieData[3] = .favorites(data)
                self?.delegate?.updateData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        APICaller.shared.getTVshow {[weak self] (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                self?.movieData[4] = .watched(data)
                self?.delegate?.updateData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
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
