//
//  SearchViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    
    @IBOutlet weak var testLabel: UILabel!
    
    var transferTextLabel: String?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Search"
        testLabel.text = "Search Page"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeWindow))
        navigationItem.leftBarButtonItem?.tintColor = .black

    }
    
    @objc func closeWindow() {
        dismiss(animated: true)
    }
    

}
