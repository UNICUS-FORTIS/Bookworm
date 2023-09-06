//
//  MemoTableViewCell.swift
//  CollectionViewPractice
//
//  Created by LOUIE MAC on 2023/09/06.
//

import UIKit
import SnapKit
import RealmSwift


class MemoTableViewCell: UITableViewCell {
    
    var bookImage: UIImage?
    var bookData: BookTable? {
        didSet {
            posterImage.image = bookImage
            titleLabel.text = bookData?.title
            priceLabel.text = "\(makingCurrency(price: bookData?.price ?? 0))원"
        }
    }
    
    private let posterImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 2
        // MARK: - TEST
        view.backgroundColor = .cyan
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private let memofield: UITextView = {
        let view = UITextView()
        view.font = .systemFont(ofSize: 16)
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        view.isEditable = false
        return view
    }()
    
    private let inspectorButton: UIButton = {
        let btn = UIButton()
        var attString = AttributedString("구매하기")
        attString.font = .systemFont(ofSize: 14, weight: .light)
        attString.foregroundColor = .white
        
        var configuration = UIButton.Configuration.filled()
        configuration.attributedTitle = attString
        btn.configuration = configuration
        btn.layer.cornerRadius = 6
        btn.clipsToBounds = true
        return btn
    }()
    
    private lazy var labelStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [titleLabel, priceLabel])
        sv.axis = .vertical
        sv.distribution = .fillEqually
        sv.spacing = 4
        sv.alignment = .leading
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configuration()
        setConstraints()
        self.selectionStyle = . none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        posterImage.image = nil
    }
    
    private func configuration() {
        let componentsArray = [posterImage, labelStackView, memofield, inspectorButton]
        componentsArray.forEach { contentView.addSubview($0) }
        
        DispatchQueue.main.async {
            self.posterImage.layer.cornerRadius = self.posterImage.frame.width / 6
            self.posterImage.clipsToBounds = true
        }
    }
    
    private func setConstraints() {
            
        posterImage.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(12)
            make.height.equalTo(contentView).multipliedBy(0.3)
            make.width.equalTo(contentView).multipliedBy(0.2)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(posterImage)
            make.leading.equalTo(posterImage.snp.trailing).offset(12)
            make.trailing.equalTo(contentView.snp.trailing).offset(-12)
            make.height.equalTo(posterImage)
        }
        
        memofield.snp.makeConstraints { make in
            make.top.equalTo(posterImage.snp.bottom).offset(6)
            make.horizontalEdges.equalTo(contentView).inset(12)
            make.height.equalTo(contentView).multipliedBy(0.3)
        }
        
        inspectorButton.snp.makeConstraints { make in
            make.width.equalTo(contentView).multipliedBy(0.5)
            make.top.equalTo(memofield.snp.bottom).offset(24)
            make.bottom.equalTo(contentView).offset(-24)
            make.centerX.equalTo(contentView)
//            make.height.equalTo(posterImage).multipliedBy(0.4)
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
