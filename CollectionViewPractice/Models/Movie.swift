//
//  Movie.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit


struct Movie {
    var poster: UIImage? {
        return UIImage(named: "\(title).png") ?? UIImage(systemName: "star")
    }
    let title: String
    let releaseDate: String
    let runtime: Int
    let overview: String
    let rate: Double
}
