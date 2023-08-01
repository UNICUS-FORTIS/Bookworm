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
    var resultArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 150
        tableView.dataSource = self
//        searchBar.delegate = self
        navigationSettings()
        searchBarSettings()

    }
    
    func navigationSettings() {
        title = "Search"

        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeWindow))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    // MARK: - addSearch방식
    func searchBarSettings() {

        searchBar.searchTextField.addTarget(self, action: #selector(findTitle), for: .editingChanged)
    }

    @objc func findTitle(_ word:UISearchBar) {
        guard let text = searchBar.text else { return }
        let matched = movieInfo.movie.filter { $0.title.contains(text) }.map { $0.title }
        for i in matched {
            resultArray.append(i)
        }
        tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier) as! SearchTableViewCell
        let filtered = movieInfo.movie.filter { resultArray.contains($0.title) }
        let row = filtered[indexPath.row]
        cell.cellConfiguration(row)
        
        return cell
    }


}
//
//extension SearchViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("\(movieInfo.movie.map { $0.title.contains(searchText) }) \(#function) \(searchText)")
//    }
//}
