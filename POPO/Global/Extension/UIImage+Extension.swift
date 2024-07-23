//
//  UIImage+Extension.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/24/24.
//

import UIKit

extension UIImage {
    static var userClover: UIImage {
        guard let image = UIImage(named: "Clover") else { return UIImage() }
        return image
    }
}
