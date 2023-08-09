//
//  SearchViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class SearchViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    let movieInfo = MovieInfo.shared
    lazy var searchTerm:String = ""
    
    var resultArray: [Book] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        tableView.dataSource = self
//        searchBar.delegate = self
        let nib = UINib(nibName: SearchTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SearchTableViewCell.identifier)
//        navigationSettings()
        searchBookInfo(query: searchTerm)
    }
    
    func searchBookInfo(query: String) {
        let bookName = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?target=title&query=\(bookName)&page=1&size=10"
        let header: HTTPHeaders = ["Authorization": "KakaoAK 489dbf20e5808f75407c213c7d4a1f40"]
        
        AF.request(url, method: .get, headers: header).validate().responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                for item in json["documents"].arrayValue {
                    
                    let thumbnail = item["thumbnail"].stringValue
                    let title = item["title"].stringValue
                    let publisher = item["publisher"].stringValue
                    let price = item["price"].intValue
                    
                    let data = Book(thumbnail: thumbnail, title: title, publisher: publisher, price: price)
                    
                    self?.resultArray.append(data)
                }
                print(self?.resultArray)
                self?.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
//    func navigationSettings() {
//        title = "Search"
//
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .done, target: self, action: #selector(closeWindow))
//        navigationItem.leftBarButtonItem?.tintColor = .black
//    }
    
    // MARK: - addTarget방식
//    func searchBarSettings() {
//        searchBar.searchTextField.addTarget(self, action: #selector(findTitle), for: .editingChanged)
//    }

//    @objc func findTitle(_ word:UISearchBar) {
//        guard let text = searchBar.text else { return }
//
//        var previousLetters:String = ""
//
//        let matched = movieInfo.movie.filter { $0.title.contains(text) }.map { $0.title }
//        print(matched)
//        if text == previousLetters {
//            return
//        }
//        for i in matched {
//            if !resultArray.contains(i) {
//                resultArray.insert(i, at: 0)
//                print(resultArray)
//            }
//        }
//        if matched.isEmpty || text.isEmpty {
//            resultArray.removeAll(keepingCapacity: true)
//        }
//        if !previousLetters.isEmpty {
//            let previousMatched = movieInfo.movie.filter { $0.title.contains(previousLetters) }.map { $0.title }
//            for i in previousMatched {
//                if !matched.contains(i), let index = resultArray.firstIndex(of: i) {
//                    resultArray.remove(at: index)
//                }
//            }
//        }
//        previousLetters = text
//    }
    
    
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
        cell.bookTitle.text = resultArray[indexPath.row].title
        cell.price.text = String(resultArray[indexPath.row].price)
        cell.publisher.text = resultArray[indexPath.row].publisher
        
        if let imgUrl = URL(string: resultArray[indexPath.row].thumbnail) {
            cell.poster.kf.setImage(with: imgUrl)
        }
        return cell
        
//            let filtered = movieInfo.movie.filter { resultArray.contains($0.title) }
//            let row = filtered[indexPath.row]
//            cell.cellConfiguration(row)
//            return cell
            //        if let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell") as? SearchTableViewCell {
            //            let row = movieInfo.movie[indexPath.row]
            //            cell.cellConfiguration(row)
            //            return cell
            //        }
            //        return UITableViewCell()
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        resultArray.removeAll()
        guard let newSearchTerm = searchBar.text else { return }
        searchBookInfo(query: newSearchTerm)
    }
}
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print("\(movieInfo.movie.map { $0.title.contains(searchText) }) \(#function) \(searchText)")
//    }
