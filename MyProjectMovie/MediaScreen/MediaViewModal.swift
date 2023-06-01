import Foundation
import RxSwift

final class MediaViewModal {
    
    lazy var dataSourceNews: [News] = []
    private (set) var shouldReloadTableViewPublishSubject = PublishSubject<Void>()
    private lazy var disposeBag = DisposeBag()
    private var apiclientGetNews: Apiclient
    lazy var titleForHeaderSection = "Новости и статьи"
    lazy var label = "Медиа"
    
    init(apiclientGetNews: Apiclient) {
        self.apiclientGetNews = apiclientGetNews
        getData()
    }
    
    func getData() {
        apiclientGetNews.getNews()
            .observe(on: MainScheduler.instance)
               .subscribe(onNext: { [weak self] news in
                   self?.dataSourceNews = news
                   self?.shouldReloadTableViewPublishSubject.onNext(())
               }, onError: { error in
                   print(error.localizedDescription)
               })
               .disposed(by: disposeBag)
    }
}

