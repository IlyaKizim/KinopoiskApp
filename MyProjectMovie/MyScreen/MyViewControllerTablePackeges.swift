import UIKit
import CoreData

final class MyViewControllerTablePackeges: UIViewController, ViewModelDelegate {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MyTableViewCellPackages.self, forCellReuseIdentifier: MyTableViewCellPackages.identifire)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        return tableView
    }()
    
    private var myViewModel = MyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myViewModel.updateData()
        setUp()
    }
    
    private func setUp() {
        addSubview()
        addConstraints()
        myViewModel.delegate = self
    }
    
    private func addSubview() {
        view.addSubview(tableView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension MyViewControllerTablePackeges: UITableViewDelegate, UITableViewDataSource {
    
    func didUpdateData() {
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MyViewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCellPackages.identifire, for: indexPath)  as? MyTableViewCellPackages else {return UITableViewCell()}
        cell.configuration(with: MyViewModel.tasks[indexPath.row])
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            MyViewModel.tasks.remove(at: indexPath.row)
            myViewModel.deleateData(indexPath: indexPath)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(myViewModel.heightForRowAt())
    }
}
