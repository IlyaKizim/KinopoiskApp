//
//  MyViewModel.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 16.01.2023.
//

import Foundation
import RxCocoa
import RxSwift

class MyViewModel {
    
    var array = BehaviorRelay<[String]>(value: [])
    
    func setUp() {
        let values = [
            "Буду смотреть",
            "Загрузки",
            "Покупки",
            "Папки"
        ]
        array.accept(values)
    }
}
