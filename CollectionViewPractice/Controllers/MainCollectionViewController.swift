//
//  MainCollectionViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit


final class MainCollectionViewController: UICollectionViewController {
    
    var movieInfo = MovieInfo.shared
    let searchBar = UISearchBar()
    
    var searchResult:[String] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewCellNib()
        setCollectionViewLayout()
        setupSearchBar()
    }
    
    func registerCollectionViewCellNib() {
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.identifier)
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
        searchBar.placeholder = "검색어를 입력하세요"
    }
    
    func setCollectionViewLayout() {
        // cell의 estimated size 를 none 으로 인터페이스 빌더에서 설정할것
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 10
        // 이게 아이폰에서 디바이스 넓이를 가지고올수있는 코드
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width/2, height: width/2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        collectionView.collectionViewLayout = layout
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.isEmpty ? movieInfo.movie.count : searchResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        
        
        if searchResult.isEmpty {
            let row = movieInfo.movie[indexPath.row]
            cell.cellConfiguration(row: row)
        } else {
            let filtered = movieInfo.movie.filter { searchResult.contains($0.title) }
            let filteredRow = filtered[indexPath.row]
            cell.cellConfiguration(row: filteredRow)
        }
        
        cell.likeButton.tag = indexPath.row
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func likeButtonTapped(_ sender:UIButton) {
        movieInfo.movie[sender.tag].like.toggle()
        collectionView.reloadData()
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let nav = UINavigationController(rootViewController: vc)
        let movieInfoIndexPathWithRow = movieInfo.movie[indexPath.row]
        nav.modalPresentationStyle = .fullScreen
        
        navigationController?.pushViewController(vc, animated: true)
        // Movie
        vc.transferMovieimage = movieInfoIndexPathWithRow.poster
        vc.transferTitleReleaseRuntime = """
        \(movieInfoIndexPathWithRow.title) |  \(movieInfoIndexPathWithRow.releaseDate) |   \(movieInfoIndexPathWithRow.rate)
        """
        vc.transferRate = String(movieInfoIndexPathWithRow.rate)
        vc.transferLike = movieInfoIndexPathWithRow.like
        vc.transferMovieDescription = movieInfoIndexPathWithRow.overview
        vc.indexPath = indexPath.row
        
        
    }
    //    @IBAction func searchBarTapped(_ sender: UIBarButtonItem) {
    //
    //        let sb = UIStoryboard(name: "Main", bundle: nil)
    //        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
    //        //네비게이션 방식으로 접근하려면 아래 코드사용해야됨.
    //        let nav = UINavigationController(rootViewController: vc)
    //        nav.modalPresentationStyle = .popover // 모달방식
    //        present(nav,animated: true)
    //    }
}

extension MainCollectionViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchResult.removeAll()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResult.removeAll()
        searchBar.text = ""
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        var previousLetters:String = ""
        let matched = movieInfo.movie.filter { $0.title.contains(text) }.map { $0.title }
        for i in matched {
            if !searchResult.contains(i) {
                searchResult.insert(i, at: 0)
                print(searchResult)
            }
        }
        if matched.isEmpty || text.isEmpty {
            searchResult.removeAll(keepingCapacity: true)
        }
        if !previousLetters.isEmpty {
            let previousMatched = movieInfo.movie.filter { $0.title.contains(previousLetters) }.map { $0.title }
            for i in previousMatched {
                if !matched.contains(i), let index = searchResult.firstIndex(of: i) {
                    searchResult.remove(at: index)
                }
            }
        }
        previousLetters = text
    }
}
