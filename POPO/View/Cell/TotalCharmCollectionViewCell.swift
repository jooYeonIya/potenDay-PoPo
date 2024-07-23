//
//  TotalCharmCollectionViewCell.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

class TotalCharmCollectionViewCell: UICollectionViewCell {
    static let identifier = "TotalCharmCollectionViewCell"
    
    lazy var imageView = UIImageView()
    lazy var label = UILabel()
    
    func configure(with text: String) {
        imageView.image = UIImage(named: "Charm")
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        
        label.text = "이루어져라 얍 (클로버)"
        
        contentView.addSubviews([imageView, label])
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(4)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
