//
//  CollectionViewCell.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CollectionViewCell"
    
    @IBOutlet weak var viewForLayout: UIView!
    @IBOutlet weak var viewforRateTitleLayout: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    
    
    func cellConfiguration(row: Movie) {
        posterImageView.image = row.poster
        movieTitle.text = row.title
        movieTitle.textColor = .white
        rate.text = String(row.rate)
        rate.textColor = .white
        viewForLayout.backgroundColor = UIColor.random()
        viewForLayout.clipsToBounds = true
        viewForLayout.layer.cornerRadius = 20
        viewforRateTitleLayout.backgroundColor = .clear
        
        
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//
//
    
    
    
}
