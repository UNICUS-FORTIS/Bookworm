//
//  LookAroundCollectionViewCell.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/08/02.
//

import UIKit

class LookAroundCollectionViewCell: UICollectionViewCell {

    static let identifier = "LookAroundCollectionViewCell"
    
    
    @IBOutlet weak var movieImage: UIImageView!
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//
    func cellConfiguration(with item: Movie) {
        movieImage.image = item.poster
    }
    
    
    
    
}
