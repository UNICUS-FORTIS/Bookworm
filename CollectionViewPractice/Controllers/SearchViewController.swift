//
//  SearchViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    let movieInfo = MovieInfo.shared
    var resultCounter:Int = 0
    
    var resultArray: [String] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        tableView.dataSource = self
        let nib = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
        //        searchBar.delegate = self
        navigationSettings()
        searchBarSettings()
    }
    
    func navigationSettings() {
        title = "Search"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeWindow))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    // MARK: - addTarget방식
    func searchBarSettings() {
        
        searchBar.searchTextField.addTarget(self, action: #selector(findTitle), for: .editingChanged)
    }

    @objc func findTitle(_ word:UISearchBar) {
        guard let text = searchBar.text else { return }
        
        var previousLetters:String = ""
        
        let matched = movieInfo.movie.filter { $0.title.contains(text) }.map { $0.title }
        print(matched)
        if text == previousLetters {
            return
        }
        for i in matched {
            if !resultArray.contains(i) {
                resultArray.insert(i, at: 0)
                print(resultArray)
            }
        }
        if matched.isEmpty || text.isEmpty {
            resultArray.removeAll(keepingCapacity: true)
        }
        if !previousLetters.isEmpty {
            let previousMatched = movieInfo.movie.filter { $0.title.contains(previousLetters) }.map { $0.title }
            for i in previousMatched {
                if !matched.contains(i), let index = resultArray.firstIndex(of: i) {
                    resultArray.remove(at: index)
                }
            }
        }
        previousLetters = text
    }
    
    
    @objc func closeWindow() {
        dismiss(animated: true)
    }
    
}

extension SearchViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as? SearchTableViewCell {
            let filtered = movieInfo.movie.filter { resultArray.contains($0.title) }
            let row = filtered[indexPath.row]
            cell.cellConfiguration(row)
            return cell
            //        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell {
            //            let row = movieInfo.movie[indexPath.row]
            //            cell.cellConfiguration(row)
            //            return cell
            //        }
            //        return UITableViewCell()
        }
        return UITableViewCell()
    }
}
//extension SearchViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("\(movieInfo.movie.map { $0.title.contains(searchText) }) \(#function) \(searchText)")
//    }
//}
