//
//  UIView+Extension.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

extension UIView {

    func addSubviews(_ views: [UIView]) {
        views.forEach {
            addSubview($0)
        }
    }
    
}
