//
//  LikeTableViewCell.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/05.
//

import UIKit
import Kingfisher
import RealmSwift

class LikeTableViewCell: UITableViewCell {
    
    var bookImage: UIImage?
    var bookData: BookTable? {
        didSet {
            poster.image = bookImage
            titleLabel.text = bookData?.title
            priceLabel.text = "\(makingCurrency(price: bookData?.price ?? 0))원"
            contentLabel.text = bookData?.contents
        }
    }
    
    let poster: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 3
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel, priceLabel, contentLabel])
        sv.axis = .vertical
        sv.alignment = .top
        sv.distribution = .fillProportionally
        sv.spacing = 4
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
        self.selectionStyle = . none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(poster)
        contentView.addSubview(stackView)
        DispatchQueue.main.async {
            self.poster.layer.cornerRadius = self.poster.frame.width / 6
            self.poster.clipsToBounds = true
        }
    }
    
    private func setConstraints() {
        let spacing = 12
        
        poster.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(spacing)
            make.leading.equalTo(contentView).inset(spacing)
            make.height.equalTo(contentView).multipliedBy(0.8)
            make.width.equalTo(contentView).multipliedBy(0.2)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(poster.snp.trailing).offset(spacing)
            make.centerY.equalTo(poster)
            make.height.equalTo(contentView)
            make.trailing.equalTo(contentView).inset(spacing)
        }
    }
    
    private func makingCurrency(price: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale(identifier: "ko_KR") // 한국 로케일을 사용할 경우
        numberFormatter.currencySymbol = ""
        if let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) {
            return formattedPrice
        }
        return ""
    }
}
