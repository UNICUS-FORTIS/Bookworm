//
//  MainCollectionViewController.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/07/31.
//

import UIKit


final class MainCollectionViewController: UICollectionViewController {

    let movieinfo = MovieInfo()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        
        setCollectionViewLayout()
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
        return movieinfo.movie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as! CollectionViewCell
        let row = movieinfo.movie[indexPath.row]
        cell.cellConfiguration(row: row)
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        let movieInfoIndexPathWithRow = movieinfo.movie[indexPath.row]
//        vc.transferToMovieImage = movieInfoIndexPathWithRow.poster
//        vc.transferToDetailLabel = movieInfoIndexPathWithRow.title
//        vc.transferToOpeningDateLabel = movieInfoIndexPathWithRow.releaseDate
//        vc.transferToRunningTimeLabel = String(movieInfoIndexPathWithRow.runtime)
//        vc.transferToRateLabel = String(movieInfoIndexPathWithRow.rate)
        vc.transferTextLabel = movieInfoIndexPathWithRow.title
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    @IBAction func searchBarTapped(_ sender: UIBarButtonItem) {
      
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        //네비게이션 방식으로 접근하려면 아래 코드사용해야됨.
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen // 모달방식
        present(nav,animated: true)
    }
    
    
    
}
