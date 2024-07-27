//
//  SegmentedOption.swift
//  POPO
//
//  Created by 강주연 on 7/26/24.
//

import Foundation
import UIKit

enum SegmentedOption: Int {
    case popo
    case viki
    
    var title: String {
        switch self {
        case .popo: return "포포"
        case .viki: return "비키"
        }
    }
    
    var description: String {
        switch self {
        case .popo:
            return """
                    안녕? 내 이름은 포포(PoPo).
                    긍정의 힘에서 따온 말이래.
                    무엇이든 긍적으로 바꿔줄게!
                    """
        case .viki:
            return "안뇽? 나는 비키(Vicky)얌! \n 이렇게 만나다니 완전 럭키비키자낭🍀 내가 뭐든 럭키하게 바꿔줄겡"
        }
    }
    
    var imageName: String {
        switch self {
        case .popo: return "Charactor_Main"
        case .viki: return "Charactor_Viki"
        }
    }
    
    var apiName: String {
        switch self {
        case .popo: return "POPO"
        case .viki: return "VIKI"
        }
    }
    
    var circleColor: UIColor {
        switch self {
        case .popo: return UIColor.userLightGreen
        case .viki: return UIColor.userPink
        }
    }
}
