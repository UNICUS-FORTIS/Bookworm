//
//  MemoViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/06.
//

import UIKit
import RealmSwift

final class MemoViewController: UIViewController {

    private let repository = BookTableRepository()
    private let mainView = MemoView()
    private var tasks: Results<BookTable>!
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.tableView.dataSource = self
        connectRealm()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainView.tableView.reloadData()
    }
    
    private func connectRealm() {
        self.tasks = repository.fetch(ketpath: "title", ascending: true)
        
    }

}

extension MemoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MemoTableViewCell.identifier) as? MemoTableViewCell else { return UITableViewCell() }
        
        let data = tasks[indexPath.row]
        cell.bookImage = loadImageFromDocument(filename: "\(data._id)thumb.png")
        cell.bookData = data
        
        return cell
    }
}
