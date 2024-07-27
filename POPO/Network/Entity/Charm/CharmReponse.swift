//
//  CharmReponse.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/26/24.
//

import Foundation

struct CharmReponse: Codable {
    let data: CharmData
    let code: Int
    let message: String
}

struct CharmData: Codable {
    let fourIdioms, message: String

    enum CodingKeys: String, CodingKey {
        case fourIdioms = "four_idioms"
        case message
    }
}
