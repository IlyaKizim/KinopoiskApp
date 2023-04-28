import Foundation

protocol ViewModelDelegate: AnyObject {
    func didUpdateData()
}

final class MyViewModel {
    
    lazy var array = ["Буду смотреть", "Загрузки", "Покупки", "Папки"]
    lazy var title = "МОЁ"
    lazy var imageArray = ["star.circle", "heart.circle", "hand.thumbsup.fill", "folder.fill", "person.circle"]
    lazy var labelArray = ["Оценки и просмотры", "Любимые фильмы", "Рекомендуемые фильмы", "Примечания", "Персоны"]
    lazy var text = "Загружайте фильмы и сериалы, чтобы смотреть их без интернета"
    
    lazy var coreDataManager = CoreDataManager()
    lazy var rateMovies: [RateMovie] = []
    weak var delegate: ViewModelDelegate?
    lazy var coreDataManagerTwo = CoreDataManagerTwo()
    static var tasks: [RateMovie] = []
    static var dict: [String: [Title]] = [:]
    static var willSee = [WillSee]()
    
    func numberOfRowsInSection () -> Int {
        1
    }
    
    func heightForRow (indexPath: IndexPath) -> Int {
        switch indexPath.section {
        case 0: return 0
        case 1: return 220
        case 2: return 0
        case 3: return 200
        default:
            return 10
        }
    }
    func heightForRowWithCount (indexPath: IndexPath) -> Int {
        switch indexPath.section {
        case 0: return 200
        case 1: return 220
        case 2: return 0
        case 3: return 200
        default:
            return 10
        }
    }
    
    func heightForHeaderInSection() -> Int {
        50
    }
    
    func updateData() {
        coreDataManager.updateData()
        rateMovies = MyViewModel.tasks
        delegate?.didUpdateData()
        }
    
    func deleateData (indexPath: IndexPath){
        coreDataManager.deleteData(indexPath: indexPath)
        delegate?.didUpdateData()
    }
    
    func heightForRowAt() -> Int {
        140
    }
    
    func updateCoreData() {
        coreDataManagerTwo.updateData()
        delegate?.didUpdateData()
    }
}
