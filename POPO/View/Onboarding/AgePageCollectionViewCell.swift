//
//  AgePageCollectionViewCell.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/24/24.
//

import UIKit
import SnapKit

class AgePageCollectionViewCell: UICollectionViewCell {
    
    func configure(text: String) {
        let label = CustomLabel(text: text, font: .body(ofSize: 15))
        label.textColor = .userGray(4)
        
        contentView.addSubview(label)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
