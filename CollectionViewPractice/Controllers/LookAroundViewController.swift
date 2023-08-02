//
//  LookAroundViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/08/02.
//

import UIKit

class LookAroundViewController: UIViewController {
    
    
    @IBOutlet weak var collectionViewLA: UICollectionView!
    @IBOutlet weak var tableViewLA: UITableView!
    
    let movieInfo = MovieInfo.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLA.dataSource = self
        collectionViewLA.delegate = self
        tableViewLA.dataSource = self
        tableViewLA.delegate = self
        tableViewLA.rowHeight = 120
        
        setupUI()
        setCollectionViewLayout()
    }
    
    // MARK: - Create Nib Information with Register to ViewController
    func setupUI() {
        let collectionNib = UINib(nibName: LookAroundCollectionViewCell.identifier, bundle: nil)
        collectionViewLA.register(collectionNib, forCellWithReuseIdentifier: LookAroundCollectionViewCell.identifier)
        
        let tableNib = UINib(nibName: LookAroundTableViewCell.identifier, bundle: nil)
        tableViewLA.register(tableNib, forCellReuseIdentifier: LookAroundTableViewCell.identifier
        )
    }
    
    // MARK: - CollrctionView Layout Settings
    func setCollectionViewLayout() {
        // cell의 estimated size 를 none 으로 인터페이스 빌더에서 설정할것
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 10
        // 이게 아이폰에서 디바이스 넓이를 가지고올수있는 코드
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: width/3, height: width/2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        collectionViewLA.collectionViewLayout = layout
        layout.minimumInteritemSpacing = spacing
        //minimumLineSpacing -> 이거 250으로 하니까 호리저널 far each other
        layout.minimumLineSpacing = spacing
        collectionViewLA.collectionViewLayout = layout
    }
}


// MARK: - Collection View Datasource
extension LookAroundViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieInfo.movie.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionViewLA.dequeueReusableCell(withReuseIdentifier: LookAroundCollectionViewCell.identifier, for: indexPath) as! LookAroundCollectionViewCell
        let item = movieInfo.movie[indexPath.item]
        
        cell.cellConfiguration(with: item)
        return cell
    }
}

// MARK: - Collection View Delegate
extension LookAroundViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        let movieInfoIndexPathWithItem = movieInfo.movie[indexPath.item]
        
        vc.transferMovieimage = movieInfoIndexPathWithItem.poster
        vc.transferTitleReleaseRuntime = """
        \(movieInfoIndexPathWithItem.title) |  \(movieInfoIndexPathWithItem.releaseDate) |   \(movieInfoIndexPathWithItem.rate)
        """
        vc.transferRate = String(movieInfoIndexPathWithItem.rate)
        vc.transferLike = movieInfoIndexPathWithItem.like
        vc.transferMovieDescription = movieInfoIndexPathWithItem.overview
        vc.indexPath = indexPath.item
        
        present(vc, animated: true)
    }
    
}

// MARK: - Table View DataSource
extension LookAroundViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movieInfo.movie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewLA.dequeueReusableCell(withIdentifier: LookAroundTableViewCell.identifier) as! LookAroundTableViewCell
        let row = movieInfo.movie[indexPath.row]
        cell.selectionStyle = .none
        cell.cellConfiguration(row)
        
        return cell
    }
}

// MARK: - Table View Delegate
extension LookAroundViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as! DetailViewController
        
        let movieInfoIndexPathWithRow = movieInfo.movie[indexPath.row]
        
        vc.transferMovieimage = movieInfoIndexPathWithRow.poster
        vc.transferTitleReleaseRuntime = """
        \(movieInfoIndexPathWithRow.title) |  \(movieInfoIndexPathWithRow.releaseDate) |   \(movieInfoIndexPathWithRow.rate)
        """
        vc.transferRate = String(movieInfoIndexPathWithRow.rate)
        vc.transferLike = movieInfoIndexPathWithRow.like
        vc.transferMovieDescription = movieInfoIndexPathWithRow.overview
        vc.indexPath = indexPath.row
        
        
        present(vc, animated: true)
    }
}
