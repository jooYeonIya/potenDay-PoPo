//
//  UserInfoRequest.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import Foundation

struct UserInfoRequest: Codable {
    let age: String
    let name: String
    let deviceId: String
}

enum Ages: Int, CaseIterable {
    case age0to9
    case age10to14
    case age15to19
    case age20to24
    case age25to29
    case age30to34
    case age35to39
    case age40
    case age50
    
    var description: String {
        switch self {
        case .age0to9:
            return "0-9"
        case .age10to14:
            return "10-14"
        case .age15to19:
            return "15-19"
        case .age20to24:
            return "20-24"
        case .age25to29:
            return "25-29"
        case .age30to34:
            return "30-34"
        case .age35to39:
            return "35-39"
        case .age40:
            return "40대"
        case .age50:
            return "50대 이상"
        }
    }
    
    var apiAge: String {
        switch self {
        case .age0to9:
            return "CHILD"
        case .age10to14:
            return "EARLY_TEEN"
        case .age15to19:
            return "LATE_TEEN"
        case .age20to24:
            return "EARLY_TWENTY"
        case .age25to29:
            return "LATE_TWENTY"
        case .age30to34:
            return "EARLY_THIRTY"
        case .age35to39:
            return "LATE_THIRTY"
        case .age40:
            return "FORTY대"
        case .age50:
            return "SENIORS"
        }
    }
    
    static func from(number: Int) -> Ages? {
        return Ages(rawValue: number)
    }
}
