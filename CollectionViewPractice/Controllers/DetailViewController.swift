//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    static let identifier = "DetailViewController"
    var movieInfo = MovieInfo()
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titleReleaseRuntime: UILabel!
    @IBOutlet weak var rate: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var movieDescription: UITextView!
    
    
    
    // Movie
    var transferMovieimage: UIImage?
    var transferTitleReleaseRuntime: String?
    var transferRate: String?
    var transferLike: Bool?
    var transferMovieDescription: String?
    
    var indexPath: Int?
    
    let heartIcon:UIImage? = UIImage(systemName: "heart")
    let heartIconFilled:UIImage? = UIImage(systemName: "heart.fill")

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieImage.image = transferMovieimage
        titleReleaseRuntime.text = transferTitleReleaseRuntime
        movieDescription.text = transferMovieDescription
        
        //싱글톤객체로 생성한 정보 갖고와도 다시 디테일뷰로 진입하면 false 로 바뀜
        setupLikebutton()
    }
    
    
    func setupLikebutton() {
        if let index = indexPath {
            if movieInfo.movie[index].like {
                likeButton.setImage(heartIconFilled, for: .normal)
            } else if movieInfo.movie[index].like {
                likeButton.setImage(heartIcon, for: .normal)
            }
            print(movieInfo.movie[index].like)
        }
    }

    @IBAction func likeButtonTapped(_ sender: UIButton) {
        if let index = indexPath {
            if movieInfo.movie[index].like == true {
                likeButton.setImage(heartIcon, for: .normal)
                movieInfo.movie[index].like.toggle()
                print(movieInfo.movie[index].like)
            } else if movieInfo.movie[index].like == false {
                likeButton.setImage(heartIconFilled, for: .normal)
                movieInfo.movie[index].like.toggle()
                print(movieInfo.movie[index].like)
            }
        }
    }
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
}


