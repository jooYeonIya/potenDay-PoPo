//
//  TotalCharmCollectionViewCell.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class TotalCharmCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView = UIImageView()
            
    func configure(_ image: UIImage) {
        contentView.addSubviews([imageView])
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
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
            make.center.equalToSuperview()
            make.width.height.equalToSuperview()
        }
    }
}
