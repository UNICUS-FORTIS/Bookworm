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
    let realm = try! Realm()
   
    override func loadView() {
        self.view = likeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeView.tableView.dataSource = self
        likeView.tableView.delegate = self
        connectRealm()
    }
    
    private func connectRealm() {
        print(#function)
        let realm = try! Realm()
        self.tasks = realm.objects(BookTable.self).sorted(byKeyPath: "title", ascending: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print(#function)
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

            try! self?.realm.write {
                self?.realm.delete(data)
            }
            tableView.reloadData()
        }
        
        remove.image = UIImage(systemName: "trash")
        remove.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [remove])
    }
    
}
