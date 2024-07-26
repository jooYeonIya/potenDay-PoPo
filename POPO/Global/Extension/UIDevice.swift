//
//  UIDevice.swift
//  POPO
//
//  Created by 강주연 on 7/26/24.
//

import UIKit

extension UIDevice {
    var hasHomeButton: Bool {
        if #available(iOS 11.0, *) {
            let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
            if let safeAreaInsets = keyWindow?.safeAreaInsets, safeAreaInsets.bottom > 0 {
                return false
            }
        }
        return true
    }
}

