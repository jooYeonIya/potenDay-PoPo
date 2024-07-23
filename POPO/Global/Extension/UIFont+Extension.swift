//
//  UIFont+Extension.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/23/24.
//

import UIKit

struct FontName {
    static let point = "UhBeeSe_hyun"
    static let bodyBold = "Pretendard-Bold"
    static let body = "Pretendard-Regular"
}

extension UIFont {
    static func point(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: FontName.point, size: size) else { return systemFont(ofSize: size) }
        return font
    }
    
    static func bodyBold(ofSize  size: CGFloat) -> UIFont {
        guard let font = UIFont(name: FontName.bodyBold, size: size) else { return boldSystemFont(ofSize: size) }
        return font
    }
    
    static func body(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: FontName.body, size: size) else { return systemFont(ofSize: size) }
        return font
    }
}
