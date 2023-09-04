//
//  MainViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/04.
//

import UIKit
import RealmSwift

class MainViewController: UIViewController {
    
    var mainView = MainView()
    let networkManager = NetworkManager.shared
    var resultArray: [KakaoResults] = []
    var page = 1
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setupSearchBar() {
        mainView.searchBar.delegate = self
        mainView.searchBar.showsCancelButton = true
        mainView.searchBar.placeholder = "검색어를 입력하세요"
        navigationItem.titleView = mainView.searchBar
    }
}

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        
        cell.bookData = resultArray[indexPath.item]
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let target = resultArray[indexPath.item]
        
        let alert = UIAlertController(title: "찜하기", message: "찜하기에 등록할까요?",
                                      preferredStyle: .actionSheet)
        
        let confirm = UIAlertAction(title: "확인", style: .default) { action in
            let realm = try! Realm()
            let task = BookTable(title: target.title,
                                 price: target.price,
                                 contents: target.contents,
                                 thumbnail: target.thumbnail,
                                 url: target.url)
            
            try! realm.write {
                realm.add(task)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)

        present(alert, animated: true)
        
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        resultArray.removeAll(keepingCapacity: true)
        
        guard let query = searchBar.text else { return }
        
        let bookname = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        networkManager.requestData(bookname: bookname, page: page)  { [weak self] result in
            switch result {
            case .success(let book) :
                self?.resultArray = book.documents
                
                DispatchQueue.main.async {
                    self?.mainView.collectionView.reloadData()
                }
                
            case .failure(let error) :
                switch error {
                case .dataError:
                    print("데이터 에러")
                case .networkingError:
                    print("네트워킹 에러")
                case .parseError:
                    print("파싱 에러")
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        resultArray.removeAll(keepingCapacity: true)
        mainView.collectionView.reloadData()
    }
}
