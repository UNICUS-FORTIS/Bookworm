//
//  LikeViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/05.
//

import UIKit
import RealmSwift

class LikeViewController: UIViewController  {
    
    var likeView = LikeView()
    var tasks: Results<BookTable>!
   
    override func loadView() {
        self.view = likeView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        likeView.tableView.dataSource = self
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
        
        cell.bookData = tasks[indexPath.row]
        
        return cell
        
    }
}
