//
//  Extension+URL.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/04.
//

import Foundation

extension URL {
    
    static func requestKakaoBook(bookname: String, page: Int) -> URL? {
        let url = "https://dapi.kakao.com/v3/search/book?target=title&query=\(bookname)&page=\(page)&size=25"
        return URL(string: url)
    }
    
}
