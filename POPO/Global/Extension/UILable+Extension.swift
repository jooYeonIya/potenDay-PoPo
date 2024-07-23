//
//  UILable+Extension.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/23/24.
//

import UIKit

class CustomLabel: UILabel {
    init(text: String, font: UIFont) {
        super.init(frame: .zero)
        
        self.text = text
        self.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

