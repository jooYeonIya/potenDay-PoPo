//
//  UserInfoResponse.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/27/24.
//

import Foundation

struct UserInfoResponse: Codable {
    let data: UserData
    let code: Int
    let message: String
}

struct UserData: Codable {
    let name: String
    let age: String
    let deviceId: String?
}
