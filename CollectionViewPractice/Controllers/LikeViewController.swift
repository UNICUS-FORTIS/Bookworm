//
//  LikeViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/05.
//

import UIKit
import RealmSwift

final class LikeViewController: UIViewController  {
    
    var likeView = LikeView()
    var tasks: Results<BookTable>!
    private let repository = BookTableRepository.shared

   
    override func loadView() {
        self.view = likeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeView.tableView.dataSource = self
        likeView.tableView.delegate = self
        connectRealm()
    }
    // MARK: - Refectored Method
    private func connectRealm() {
        self.tasks = repository.fetch(ketpath: "title", ascending: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        likeView.tableView.reloadData()
    }
}

extension LikeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LikeTableViewCell.identifier) as? LikeTableViewCell else { return UITableViewCell() }
        
        let data = tasks[indexPath.row]
        cell.bookImage = loadImageFromDocument(filename: "\(data._id)thumb.png")
        cell.bookData = data
        
        return cell
    }
}

extension LikeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let data = tasks[indexPath.row]
        
        let remove = UIContextualAction(style: .destructive, title: nil) { [weak self] action, view, completionHandler in

            self?.removeImageFromDocument(filename: "\(data._id)thumb.png")
            self?.repository.removeBookInfo(data: data)
//            try! self?.realm.write {
//                self?.realm.delete(data)
//            }
            tableView.reloadData()
        }
        
        remove.image = UIImage(systemName: "trash")
        remove.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [remove])
    }
    
}
