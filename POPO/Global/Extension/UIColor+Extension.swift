//
//  UIColor+Extension.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/23/24.
//

import UIKit

struct ColorName {
    static let primary = "Primary"
    static let secondary = "Secondary"
    static let customBlack = "CustomBlack"
}

extension UIColor {
    static var userGreen: UIColor {
        guard let color = UIColor(named: ColorName.primary) else { return .systemGreen }
        return color
    }
    
    static var userLightGreen: UIColor {
        guard let color = UIColor(named: ColorName.secondary) else { return .systemGreen }
        return color
    }
    
    static var userBlack: UIColor {
        guard let color = UIColor(named: ColorName.customBlack) else { return .black }
        return color
    }
}
