import Foundation
import RxSwift

final class MediaViewModal {
    
    lazy var dataSourceNews: [News] = []
    private (set) var shouldReloadTableViewPublishSubject = PublishSubject<Void>()
 
    lazy var titleForHeaderSection = "Новости и статьи"
    lazy var label = "Медиа"
    
    func getData() {
        APICaller.shared.getNews { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.dataSourceNews = data
                    self?.shouldReloadTableViewPublishSubject.onNext(())
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
