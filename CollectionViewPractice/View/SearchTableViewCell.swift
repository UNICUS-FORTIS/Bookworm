//
//  SearchTableViewCell.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/08/01.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    static let identifier = "SearchTableViewCell"

    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var openingDate: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    
    func cellConfiguration(_ row: Movie) {
        movieImage.image = row.poster
        movieTitle.text = row.title
        openingDate.text = row.releaseDate
        rate.text = String(row.rate)
    }
    
    
    
}
