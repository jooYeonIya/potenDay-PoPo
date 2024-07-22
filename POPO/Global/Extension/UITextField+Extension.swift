//
//  UITextField+Extension.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

extension UITextField {
    func configure(width: CGFloat = CGFloat(48)) {
        layer.cornerRadius = width / 2
        layer.masksToBounds = true
        
        layer.borderColor = UIColor.green.cgColor
        layer.borderWidth = 1.0
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.size.height))
        leftView = leftPaddingView
        leftViewMode = .always
        
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: frame.size.height))
        rightView = rightPaddingView
        rightViewMode = .always
    }
}
