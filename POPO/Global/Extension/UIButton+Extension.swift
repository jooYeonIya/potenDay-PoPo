//
//  UIButton+Extension.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/24/24.
//

import UIKit
import SnapKit

struct BasicButtonOtpion {
    let backgroundColor: UIColor
    let borderColor: UIColor
    let text: String
    let image: UIImage
}

extension UIButton {
    
    // 재활용할 수 있도록 좀 더 생각해보자
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
    
    func applyBasicButton(_ option: BasicButtonOtpion) {
        let imageView = UIImageView()
        imageView.image = option.image
        
        let titleLabel = UILabel()
        titleLabel.text = option.text
        titleLabel.font = .bodyBold(ofSize: 13)
        titleLabel.textColor = .userGray(4)
        
        addSubviews([imageView, titleLabel])
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(2)

            let offset = titleLabel.intrinsicContentSize.width
            make.centerX.equalToSuperview().offset(offset)

            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(imageView.snp.leading).offset(-4)
        }
        
        layer.cornerRadius = 20
        layer.borderColor = option.borderColor.cgColor
        layer.borderWidth = 1.0
        
        backgroundColor = option.backgroundColor
        
        layer.shadowColor = UIColor.userGray(6).cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 0.8
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
