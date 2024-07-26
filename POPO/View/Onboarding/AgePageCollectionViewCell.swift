//
//  AgePageCollectionViewCell.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/24/24.
//

import UIKit
import SnapKit

class AgePageCollectionViewCell: UICollectionViewCell {
    
    let label = CustomLabel(text: "", font: .body(ofSize: 15))
    
    func configure(text: String) {
        label.text = text
        label.textColor = isSelected ? .userGreen : .userGray(4)
        
        contentView.addSubview(label)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true

        contentView.layer.borderColor = UIColor.userGreen.cgColor
        contentView.layer.borderWidth = isSelected ? 1.0 : 0.0

        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
