import Foundation

protocol MediaViewModelDelegate: AnyObject {
    func reloadData()
}

class MediaViewModal {
    
    lazy var dataSourceNews: [News] = []
    weak var delegate: MediaViewModelDelegate?
 
    let titleForHeaderSection = "Новости и статьи"
    let label = "Медиа"
    
    func heightForRowAt() -> Int {
        80
    }
    
    func getData() {
        APICaller.shared.getNews { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.dataSourceNews = data
                    self?.delegate?.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
