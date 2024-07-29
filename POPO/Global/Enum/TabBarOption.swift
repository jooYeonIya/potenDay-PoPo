//
//  TabBarOption.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/30/24.
//

import Foundation
import UIKit

enum TabBarOption: Int, CaseIterable {
    case totalCharm
    case home
    case myPage
    
    var title: String {
        switch self {
        case .totalCharm: return "부적 모아보기"
        case .home: return "홈"
        case .myPage: return "마이페이지"
        }
    }
    
    var image: UIImage {
        switch self {
        case .totalCharm: return UIImage(named: "Charm_Deselected") ?? UIImage()
        case .home: return UIImage(named: "Home_Deselected") ?? UIImage()
        case .myPage: return UIImage(named: "MyPage_Deselected") ?? UIImage()
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .totalCharm: return UIImage(named: "Charm") ?? UIImage()
        case .home: return UIImage(named: "Home") ?? UIImage()
        case .myPage: return UIImage(named: "MyPage") ?? UIImage()
        }
    }
}

