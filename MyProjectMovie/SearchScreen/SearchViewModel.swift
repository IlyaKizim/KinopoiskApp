import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func reloadData()
}

final class SearchViewModel {
    
    lazy var array = ["Категории", "Популярные персоны", "Родились сегодня"]
    lazy var searchPlaceholder = "Фильмы, персоны, кинотеатры"
    lazy var dataSourcePopular: [People] = []
    weak var delegate: SearchViewModelDelegate?
    private var apiclientGetPopularPeople: Apiclient
//    private var apiclientGetDetailActor: ApiclientGetDetailActor
//    private var apiclientgetListMoviesForActors: ApiclientGetListMoviewsForActors
//    private var apiclientSearch: ApiclientSearch
//    ApicleintGetPopularPeople, apiclientGetDetailActor: ApiclientGetDetailActor, apiclientgetListMoviesForActors: ApiclientGetListMoviewsForActors, apiclientSearch: ApiclientSearch)
    
    init(apiclientGetPopularPeople: Apiclient) {
        self.apiclientGetPopularPeople = apiclientGetPopularPeople
    }
    
    func heightForRowAt(indexPath: IndexPath) -> Int {
        switch indexPath.section {
        case 0: return 220
        case 1: return 200
        case 2: return 200
        default:
            return 100
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return 1
    }
    
    func heightForHeaderInSection() -> Int {
        return 40
    }
    
    func getData() {
        apiclientGetPopularPeople.getPopularPeople {[weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.dataSourcePopular = data
                    self?.delegate?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getDetailAndMovieActors(with string: String, vc: DetailActorsViewController) {
        apiclientGetPopularPeople.getDetailActor(with: string) { (result) in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let titles):
                    vc.detail = titles
                    vc.configureLabel(with: titles)
                    self.delegate?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        apiclientGetPopularPeople.getListMoviesForActors(with: string) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    vc.configureTableView(with: result)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func getSearch(with query: String, resultController: SearchResultsControllerViewController) {
        apiclientGetPopularPeople.search(with: query ) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    resultController.titles = titles
                    resultController.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
