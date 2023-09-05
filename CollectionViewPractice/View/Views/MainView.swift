//
//  MainView.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/04.
//

import UIKit
import SnapKit

class MainView: UIView {
    
    let searchBar = UISearchBar()

    lazy var collectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(MainCollectionViewCell.self,
                      forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        return cv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstrains()
        setCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setCollectionViewLayout(){
        let layout = UICollectionViewFlowLayout()
        let spacing:CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width/2, height: width/1.5)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing * 5
        layout.scrollDirection = .vertical
        collectionView.collectionViewLayout = layout
    }
    
    private func configureView() {
        self.addSubview(collectionView)
        self.addSubview(searchBar)
    }
    
    private func setConstrains() {
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    
}



