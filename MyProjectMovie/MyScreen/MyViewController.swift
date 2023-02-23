//
//  MyViewController.swift
//  MyProjectMovie
//
//  Created by Яна Угай on 10.01.2023.
//

import UIKit
import RxCocoa
import RxSwift

class MyViewController: UIViewController {
    
    var tableView = UITableView()
    var myModel = MyViewModel()
    let disposeBag = DisposeBag()
    
    let viewForCell: UIView = {
        let viewForCell = UIView()
        viewForCell.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        viewForCell.backgroundColor = .black
        return viewForCell
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        myModel.setUp()
        setup ()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    func setup () {
        tableView = UITableView(frame: .zero)
        tableView.register(RxTableViewCell.self, forCellReuseIdentifier: RxTableViewCell.identifire)
        myModel.array.bind(to: tableView.rx.items(cellIdentifier: RxTableViewCell.identifire, cellType: RxTableViewCell.self)) {
            row, model, cell in
            cell.configure(with: model)
        }
        .disposed(by: disposeBag)
        view.addSubview(tableView)
    }
}
