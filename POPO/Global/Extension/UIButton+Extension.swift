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
    let fontColor: UIColor
    let text: String
    let image: UIImage
}

extension UIButton {
    
    // 재활용할 수 있도록 좀 더 생각해보자
    func applyBlurButton(withImage image: UIImage, withText text: String, fontSize: CGFloat, fontColor: UIColor = .black) {
        setBackgroundImage(UIImage(named: "BlurButton"), for: .normal)
        
        setImage(image, for: .normal)
        setTitle(text, for: .normal)
        setTitleColor(fontColor, for: .normal)
        titleLabel?.font = .bodyBold(ofSize: fontSize)
    }
    
    func applyBasicButton(_ option: BasicButtonOtpion) {
        var configuration = UIButton.Configuration.plain()
        
        let attributedString = NSAttributedString(string: option.text, 
                                                  attributes: [.font: UIFont.bodyBold(ofSize: 13),
                                                               .foregroundColor: option.fontColor])
        
        configuration.attributedTitle = AttributedString(attributedString)
        configuration.image = option.image
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 4
                        
        self.configuration = configuration
       
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
