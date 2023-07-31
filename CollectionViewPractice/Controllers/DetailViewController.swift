//
//  ViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var textLabel: UILabel!
    
    
    var transferTextLabel: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = transferTextLabel
        textLabel.text = transferTextLabel

    }


}

