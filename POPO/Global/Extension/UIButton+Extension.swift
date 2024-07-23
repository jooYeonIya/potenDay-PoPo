//
//  UIButton+Extension.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/24/24.
//

import UIKit
import SnapKit

extension UIButton {
    
    func applyBlurButton(withImage image: UIImage, withText text: String, fontSize: CGFloat) {
        
        setBackgroundImage(UIImage(named: "BlurButton"), for: .normal)
        
        let imageView = UIImageView()
        imageView.image = image
        
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.font = .bodyBold(ofSize: fontSize)
        
        addSubviews([imageView, titleLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            
            let offset = image.size.width - 4
            make.centerX.equalToSuperview().offset(offset)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(titleLabel.snp.leading).offset(-4)
        }
    }
}
