import Foundation

protocol MovieDetailViewDelegate: AnyObject {
    func reloadData()
}

class MovieDetailViewModel {
    
    lazy var arrayTitle = ["Рейтинг Кинопоиска", "Актеры"]
    lazy var dataSourceActors: [ActrosWhoPlaying] = []
    lazy var coreDataManagerTwo = CoreDataManagerTwo()
    weak var delegate: ViewModelDelegate?
    weak var movieDelegate: MovieDetailViewDelegate?
    lazy var label = 0.0
    static var model = ""
    lazy var titles: [Title] = []
 
    
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
        APICaller.shared.getActorsWhoPlayingInMovie(with: query) {[weak self] (result) in
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
        APICaller.shared.getDetailActor(with: String(id)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let titles):
                    vc.detail = titles
                    vc.configureLabel(with: titles)
                    self.movieDelegate?.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        APICaller.shared.getListMoviesForActors(with: String(id)) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    vc.configureTableView(with: result)
                    self.movieDelegate?.reloadData()
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
