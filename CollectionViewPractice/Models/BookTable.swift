//
//  BookTable.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/05.
//

import Foundation
import RealmSwift

final class BookTable: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId

    @Persisted var title: String
    @Persisted var price: Int
    @Persisted var contents: String?
    @Persisted var thumbnail: String?
    @Persisted var url: String
    @Persisted var like: Bool
    @Persisted var userMemo: String?
    
    convenience init(title: String, price: Int, contents:String?, thumbnail: String?, url: String) {
        self.init()
        
        self.title = title
        self.price = price
        self.contents = contents
        self.thumbnail = thumbnail
        self.url = url
        self.like = false
        self.userMemo = nil
    }
    
}
