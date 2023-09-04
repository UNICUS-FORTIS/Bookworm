//
//  KakaoBook.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/04.
//

import Foundation

// MARK: - MyCodable
struct KakaoBook: Codable {
    let documents: [KakaoResults]
    let meta: Meta
}

// MARK: - Document
struct KakaoResults: Codable {
    let authors: [String]
    let contents, datetime, isbn: String
    let price: Int
    let publisher: String
    let salePrice: Int
    let thumbnail: String
    let status: String?
    let title: String
    let translators: [String?]
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case authors, contents, datetime, isbn, price, publisher
        case salePrice = "sale_price"
        case status, thumbnail, title, translators, url
    }
}

//enum Publisher: String, Codable {
//    case 서울음악출판사 = "서울음악출판사"
//    case 에이케이커뮤니케이션즈 = "에이케이커뮤니케이션즈"
//    case 학산문화사 = "학산문화사"
//}


// MARK: - Meta
struct Meta: Codable {
    let isEnd: Bool
    let pageableCount, totalCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isEnd = "is_end"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
    }
}
