//
//  LikeView.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/05.
//

import UIKit

class LikeView: UIView {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 120
        tv.register(LikeTableViewCell.self, forCellReuseIdentifier: LikeTableViewCell.identifier)
        return tv
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureView() {
        self.addSubview(tableView)
    }
    
    private func setConstrains() {
        tableView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    
}
