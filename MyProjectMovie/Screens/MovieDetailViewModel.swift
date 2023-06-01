import Foundation

protocol MovieDetailViewDelegate: AnyObject {
    func reloadData()
}

final class MovieDetailViewModel {
    
    lazy var arrayTitle = ["Рейтинг Кинопоиска", "Актеры"]
    lazy var dataSourceActors: [ActrosWhoPlaying] = []
    lazy var coreDataManagerTwo = CoreDataManagerTwo()
    weak var delegate: ViewModelDelegate?
    weak var movieDelegate: MovieDetailViewDelegate?
    lazy var label = 0.0
    lazy var titles: [Title] = []
    private var apiGetActorsWhoPlayingMovie: Apiclient
//    private var apiGetDetailActor: ApiclientGetDetailActor
//    private var apiGetMoviesForActor: ApiclientGetListMoviewsForActors
 
    init(apiGetActorsWhoPlayingMovie: Apiclient){
        self.apiGetActorsWhoPlayingMovie = apiGetActorsWhoPlayingMovie
    }
    
    func heightForRow (indexPath: IndexPath) -> Int {
        switch indexPath.section {
        case 0: return 200
        case 1: return 300
        default:
            return 10
        }
    }
    
    func numberOfRowsInSection() -> Int {
        1
    }
    
    func getData(query: String) {
        apiGetActorsWhoPlayingMovie.getActorsWhoPlayingInMovie(with: query) {[weak self] (result) in
            switch result {
            case .success(let results):
                self?.dataSourceActors = results
                self?.movieDelegate?.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func getDataForDetail(with vc: DetailActorsViewController, viewModel: ActrosWhoPlaying) {
       
        vc.setUpForAnotherWay(with: viewModel)
        vc.navigationItem.leftBarButtonItem?.tintColor = .white
        guard let id = viewModel.id else {return}
        apiGetActorsWhoPlayingMovie.getDetailActor(with: String(id)) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    vc.detail = titles
                    vc.configureLabel(with: titles)
                    self?.movieDelegate?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        apiGetActorsWhoPlayingMovie.getListMoviesForActors(with: String(id)) {[weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    vc.configureTableView(with: result)
                    self?.movieDelegate?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func saveCoreData(with title: Title) {
        coreDataManagerTwo.saveTask(with: title)
    }
    
    func deleateCoreData(with: Title) {
        coreDataManagerTwo.deleteData(title: with)
    }
}
