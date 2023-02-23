//
//  MediaViewModal.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 21.02.2023.
//

import Foundation

class MediaViewModal {
    
    var cellDataSource: Observable<[News]> = Observable(nil)
    var dataSourceNews: [News] = []
 
    let titleForHeaderSection = "Новости и статьи"
    let label = "Медиа"
    
    func heightForRowAt() -> Int {
        120
    }
    
    func getData() {
        APICaller.shared.getNews { [weak self] result in
            switch result {
            case .success(let data):
                self?.dataSourceNews = data
                self?.mapCellData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func mapCellData() {
        self.cellDataSource.value = self.dataSourceNews
    }
}
