import Foundation
import RxSwift

final class MainViewModel {
    
    enum MovieData {
        case popular([Title])
        case topRated([Title])
        case upcoming([Title])
        case favorites([Title])
        case watched([Title])
    }
    
    private (set) var shouldReloadTableViewPublishSubject = PublishSubject<Void>()
    private (set) var headerTitleSubject = PublishSubject<[Title]>()
    private (set) var isActivated = true
    private (set) var isActivatedTwo = true
    private lazy var disposeBag = DisposeBag()
    private var apiclient: Apiclient
    private var apiclientGetMovie: ApiclientGetMovie
    lazy var movieData: [MovieData] = [.popular([]), .topRated([]), .upcoming([]), .favorites([]), .watched([])]
    lazy var integer = 0
    lazy var randomInt = Int.random(in: 0..<integer)
    lazy var radius = 20
    lazy var titleForHeaderSection = [
        "Popular",
        "Top Rate",
        "Upcoming",
        "Favorites",
        "TV"
    ]
    private let addToInterestingSubject = PublishSubject<Void>()
    private let deleteFromAddToInterestingSubject = PublishSubject<Void>()
    private let deleteFromInterestingSubject = PublishSubject<Void>()
    private let removeFromInterestingSubject = PublishSubject<Void>()
    
    var addToInterestingObservable: Observable<Void> {
        return addToInterestingSubject.asObservable()
    }
    var deleteFromAddToInterestingObservable: Observable<Void> {
        return deleteFromAddToInterestingSubject.asObservable()
    }
    var deleteFromInterestingObservable: Observable<Void> {
        return deleteFromInterestingSubject.asObservable()
    }
    var removeFromInterestingObservable: Observable<Void> {
        return removeFromInterestingSubject.asObservable()
    }
    
    init(apiclient: Apiclient, apiclientGetMovie: ApiclientGetMovie) {
        self.apiclient = apiclient
        self.apiclientGetMovie = apiclientGetMovie
        getData()
    }
    
    func addToInteresting() {
        if isActivated {
            addToInterestingSubject.onNext(())
        } else {
            deleteFromAddToInterestingSubject.onNext(())
        }
        isActivated.toggle()
    }
    
    func deleteFromInteresting() {
        if isActivatedTwo {
            deleteFromInterestingSubject.onNext(())
        } else {
            removeFromInterestingSubject.onNext(())
        }
        isActivatedTwo.toggle()
    }
    
    func getData() {
        apiclient.getTitles(from: APIString.popular.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] titles in
                self?.movieData[0] = .popular(titles)
                self?.integer = titles.count
                self?.headerTitleSubject.onNext(titles)
                self?.shouldReloadTableViewPublishSubject.onNext(())
                self?.getMovie(string: titles.first?.originalTitle ?? "")
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        apiclient.getTitles(from: APIString.topRate.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] titles in
                self?.movieData[1] = .topRated(titles)
                self?.shouldReloadTableViewPublishSubject.onNext(())
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        apiclient.getTitles(from: APIString.upcoming.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] titles in
                self?.movieData[2] = .upcoming(titles)
                self?.shouldReloadTableViewPublishSubject.onNext(())
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        apiclient.getTitles(from: APIString.favorites.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] titles in
                self?.movieData[3] = .favorites(titles)
                self?.shouldReloadTableViewPublishSubject.onNext(())
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
        
        apiclient.getTitles(from: APIString.wathed.rawValue)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] titles in
                self?.movieData[4] = .watched(titles)
                self?.shouldReloadTableViewPublishSubject.onNext(())
            }, onError: { error in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    func getMovie(string: String) {
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


