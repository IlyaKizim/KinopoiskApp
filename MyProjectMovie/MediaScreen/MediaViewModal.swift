import Foundation
import RxSwift

final class MediaViewModal {
    
    lazy var dataSourceNews: [News] = []
    private (set) var shouldReloadTableViewPublishSubject = PublishSubject<Void>()
    private var apiclientGetNews: ApiclientGetNews
    lazy var titleForHeaderSection = "Новости и статьи"
    lazy var label = "Медиа"
    
    init(apiclientGetNews: ApiclientGetNews) {
        self.apiclientGetNews = apiclientGetNews
    }
    
    func getData() {
        apiclientGetNews.getNews { [weak self] result in
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

