//
//  LookAroundTableViewCell.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/08/02.
//

import UIKit

class LookAroundTableViewCell: UITableViewCell {

    static let identifier = "LookAroundTableViewCell"
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var openingDate: UILabel!
    @IBOutlet weak var rate: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//    }
    
    func cellConfiguration(_ row: Movie) {
        movieImage.image = row.poster
        movieTitle.text = row.title
        openingDate.text = row.releaseDate
        rate.text = String(row.rate)
    }
    
}
