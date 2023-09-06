//
//  BookTableRepository.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/06.
//

import Foundation
import RealmSwift

class BookTableRepository {
    
    static let shared = BookTableRepository()
    
    let realm = try! Realm()
    
    // MARK: - Fetch Database
    func fetch(ketpath: String, ascending: Bool) -> Results<BookTable> {
        let data = realm.objects(BookTable.self).sorted(byKeyPath: ketpath, ascending: ascending)
        return data
    }
    
    // MARK: - Filter
    func fetchFilter() -> Results<BookTable> {
        let result = realm.objects(BookTable.self).where { $0.thumbnail != "" }
        return result
    }
    
    // MARK: - Create
    func createBookItem(item: BookTable) {
        
        do {
            try realm.write {
                realm.add(item)
            }
        } catch {
            print(error)
        }
    }
    
    // MARK: - Update
    func updateBookItem(id: ObjectId, title: String, contents: String) {
        let value:[String:Any] = ["_id": id, "title": title, "contents": contents]
        do {
            try realm.write {
                realm.create(BookTable.self, value: value, update: .modified)
            }
        } catch {
            print("")
        }
    }
    
    // MARK: - Remove
    func removeBookInfo(data: BookTable) {
        
        do {
            try! realm.write {
                realm.delete(data)
            }
        }
    }
    
    // MARK: - Scheme version check
    func checkSchemaVersion() {
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print("Current version : \(version)")
        } catch {
            print(error)
        }
    }
    
}
