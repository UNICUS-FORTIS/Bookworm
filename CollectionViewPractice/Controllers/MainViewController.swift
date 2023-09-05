//
//  MainViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/04.
//

import UIKit
import RealmSwift

final class MainViewController: UIViewController {
    
    private var mainView = MainView()
    private let networkManager = NetworkManager.shared
    private var resultArray:KakaoBook?
    private var page = 1
    private var isEnd = false
    private let realm = try! Realm()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        mainView.collectionView.dataSource = self
        mainView.collectionView.delegate = self
        mainView.collectionView.prefetchDataSource = self
        navigationController?.hidesBarsOnSwipe = true
        print(realm.configuration.fileURL)
    }
    
    private func setupSearchBar() {
        mainView.searchBar.delegate = self
        mainView.searchBar.showsCancelButton = true
        mainView.searchBar.placeholder = "검색어를 입력하세요"
        navigationItem.titleView = mainView.searchBar
    }
}

// MARK: - Extensions

extension MainViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resultArray?.documents.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as! MainCollectionViewCell
        
        cell.bookData = resultArray?.documents[indexPath.row]
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let target = resultArray?.documents[indexPath.item]
        
        let alert = UIAlertController(title: "찜하기", message: "찜하기에 등록할까요?",
                                      preferredStyle: .actionSheet)
        
        let confirm = UIAlertAction(title: "확인", style: .default) { _ in
            let realm = try! Realm()
            let task = BookTable(title: target?.title ?? "",
                                 price: target?.price ?? 0,
                                 contents: target?.contents ?? "",
                                 thumbnail: target?.thumbnail ?? "",
                                 url: target?.url ?? "")
            
            try! realm.write {
                realm.add(task)
            }
            
            guard let url = URL(string: task.thumbnail) else { return }
            DispatchQueue.global().async { [weak self] in
                let data = try! Data(contentsOf: url)
                let thumbnail = UIImage(data: data)
                
                guard let thumbnail = thumbnail else { return }
                DispatchQueue.main.async {
                    self?.saveImageToDocument(filename: "\(task._id)thumb.png", image: thumbnail)
                    print("\(task._id)thumb.png, is saved")
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        present(alert, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if (resultArray?.documents.count ?? 0) - 1 == indexPath.item && page < 15 {
                page += 1
                guard let query = mainView.searchBar.text else { return }
                
                let bookname = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                networkManager.requestData(bookname: bookname, page: page)  { [weak self] result in
                    switch result {
                    case .success(let book) :
                        self?.resultArray?.documents.append(contentsOf: book.documents)
                        
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
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        print("===취소: \(indexPaths)")
    }
}

extension MainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        resultArray?.documents.removeAll(keepingCapacity: true)
        
        guard let query = searchBar.text else { return }
        
        let bookname = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        networkManager.requestData(bookname: bookname, page: page)  { [weak self] result in
            switch result {
            case .success(let book) :
                self?.resultArray = book
                
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
        resultArray?.documents.removeAll(keepingCapacity: true)
        mainView.collectionView.reloadData()
    }
}
