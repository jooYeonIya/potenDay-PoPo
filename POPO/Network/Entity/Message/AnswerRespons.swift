//
//  AnswerRespons.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/27/24.
//

import Foundation

struct AnswerRespons: Codable {
    let data: AnswerData
    let code: Int
    let message: String
}

struct AnswerData: Codable {
    let clovaMood: String
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case clovaMood = "clova_mood"
        case character
    }
}
