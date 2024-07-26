//
//  MessageResponse.swift
//  POPO
//
//  Created by 강주연 on 7/26/24.
//

import Foundation

struct MessageData: Codable {
    let clovaMood: String
    let vickyMood: String
    
    enum CodingKeys: String, CodingKey {
        case clovaMood = "clova_mood"
        case vickyMood = "vicky_mood"
    }
}

struct MessageResponse: Codable {
    let data: MessageData
    let code: Int
    let message: String
}
