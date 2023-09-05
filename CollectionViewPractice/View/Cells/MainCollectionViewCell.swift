//
//  CollectionViewCell.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/04.
//

import UIKit
import SnapKit
import Kingfisher

class MainCollectionViewCell: UICollectionViewCell {
    
    var bookData: KakaoResults? {
        didSet {
            guard let data = bookData?.thumbnail else { return }
            let url = URL(string: data)
            mainImageView.kf.setImage(with: url)
            titleLabel.text = bookData?.title
            
            if let price = bookData?.price {
                priceLabel.text = "\(makingCurrency(price: price))원"
            }
        }
    }
    
    private var mainImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        setConstraints()
        titleLabel.text = "책정보입니다"
        priceLabel.text = "가격정보"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
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
    
    private func configureView() {
        contentView.addSubview(mainImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        DispatchQueue.main.async {
            self.mainImageView.layer.cornerRadius = self.mainImageView.frame.width / 6
            self.mainImageView.clipsToBounds = true
        }
    }
    
    private func setConstraints() {

        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView)
            make.horizontalEdges.equalTo(contentView).inset(8)
            make.height.equalTo(contentView).multipliedBy(0.85)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(contentView).multipliedBy(0.1)
        }

        priceLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(contentView)
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalTo(contentView).multipliedBy(0.1)
        }
    }
}
