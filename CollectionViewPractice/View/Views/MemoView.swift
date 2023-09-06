//
//  MemoView.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/06.
//

import UIKit

final class MemoView: UIView {
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.rowHeight = 300
        tv.register(MemoTableViewCell.self, forCellReuseIdentifier: MemoTableViewCell.identifier)
        return tv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configuration() {
        self.addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.snp.makeConstraints{ $0.edges.equalToSuperview() }
    }
    
    
}
