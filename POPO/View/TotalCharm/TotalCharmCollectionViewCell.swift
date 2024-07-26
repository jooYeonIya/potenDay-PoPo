//
//  TotalCharmCollectionViewCell.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class TotalCharmCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView = UIImageView()
    lazy var label = UILabel()
            
    func configure(for indexPath: IndexPath) {
        contentView.addSubviews([imageView, label])
        
        imageView.image = UIImage(named: "DummyCharm")
        
        label.text = "2024년 7월 7일"
        label.font = .body(ofSize: 11)
        label.textColor = .userGray(5)
        label.numberOfLines = 1
        
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        
        contentView.layer.shadowColor = UIColor.userGray(6).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 1.6
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
        setupLayout()
    }

    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(contentView.snp.height).multipliedBy(0.8)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(imageView)
//            make.bottom.equalToSuperview()
        }
    }
}
