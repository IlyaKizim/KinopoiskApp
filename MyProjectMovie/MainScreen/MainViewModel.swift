
import Foundation
import RxSwift

final class MainViewModel {
    
    //MARK: Observable properties
    
    private (set) var shouldReloadTableViewPublishSubject = PublishSubject<Void>()
    private (set) var headerTitleSubject = PublishSubject<[Title]>()
    
    //MARK: Flags
    
    private (set) var isActivated = true
    private (set) var isActivatedTwo = true
    
    //MARK: Properties
    
    private var apiclient: Apiclient
    private lazy var disposeBag = DisposeBag()
    lazy var movieData: [MovieData] = [.popular([]), .topRated([]), .upcoming([]), .favorites([]), .watched([])]
    lazy var integer = 0
    lazy var randomInt = Int.random(in: 0..<integer)
    lazy var radius = 20
    lazy var titleForHeaderSection: [String] = [
        TitleHeaderSection.popular.rawValue,
        TitleHeaderSection.topRated.rawValue,
        TitleHeaderSection.upcoming.rawValue,
        TitleHeaderSection.favorites.rawValue,
        TitleHeaderSection.tv.rawValue
    ]
    
    //MARK: Subjects
    
    private let addToInterestingSubject = PublishSubject<Void>()
    private let deleteFromAddToInterestingSubject = PublishSubject<Void>()
    private let deleteFromInterestingSubject = PublishSubject<Void>()
    private let removeFromInterestingSubject = PublishSubject<Void>()
    
    //MARK: Event Tracking Properties
    
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
    
    //MARK: Initialization
    
    init(apiclient: Apiclient) {
        self.apiclient = apiclient
        getData()
    }
    
    //MARK: Metods
    
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
    
    //MARK: - Get Data
    
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
        apiclient.getMovie(with: string + " trailer")
            .observe(on: MainScheduler.instance)
            .subscribe { event in
                switch event {
                case .next(let videoElement):
                    VideoId.id = videoElement.id.videoId
                case .error(let error):
                    print(error.localizedDescription)
                case .completed:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
}


