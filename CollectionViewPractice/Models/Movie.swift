//
//  Movie.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit

// MARK: - discussion - How to avoid including UIkit framework properties in Foundation properties.
struct Movie {
    var poster: UIImage? {
        return UIImage(named: "\(title).png") ?? UIImage(systemName: "star")
    }
    let title: String
    let releaseDate: String
    let runtime: Int
    let overview: String
    let rate: Double
    var like: Bool
    var color: UIColor
}
