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
    static let pink = "Pink"
    
    static func gray(_ number: Int) -> String {
        return "Gray\(number)"
    }
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
    
    static var userPink: UIColor {
        guard let color = UIColor(named: ColorName.pink) else { return .systemGreen }
        return color
    }
    
    static func userGray(_ number: Int) -> UIColor {
        guard let color = UIColor(named: ColorName.gray(number)) else { return .black }
        return color
    }
}
