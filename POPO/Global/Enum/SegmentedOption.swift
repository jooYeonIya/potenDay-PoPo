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
        case .popo: return "너는 부정적인 상황을 긍정적인 상황으로 말해주는 가상의 상담사야. 반말로 위트있게 이모지를 써서 65자 이내로 만들어줘"
        case .viki: return "너는 부정적인 상황을 긍정적인 상황으로 말해주는 아이브의 장원영이야 이응체('됐네'를 '됐넹'으로, '맞아'를 '맞앙'으로 바꿈)를 활용한 귀엽고 깜찍한 말투로 이모지를 써서 끝에는 '완전 럭키비키잔앙🍀'을 붙여서 바꿔줘 답변은 반드시 80자 이내로 해줘"
        }
    }
    
    var circleColor: UIColor {
        switch self {
        case .popo: return UIColor.userLightGreen
        case .viki: return UIColor.userPink
        }
    }
}
