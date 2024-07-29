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

class CustomImageView: UIImageView {
    init(_ imageName: String) {
        super.init(frame: .zero)
        
        image = UIImage(named: imageName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
