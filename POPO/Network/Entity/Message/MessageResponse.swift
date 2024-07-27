//
//  MessageResponse.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/27/24.
//

import Foundation

struct MessageResponse: Codable {
    let data: MessageData
    let code: Int
    let message: String
}

// MARK: - DataClass
struct MessageData: Codable {
    let content: [Content]
    let pageable: Pageable
    let last: Bool
    let totalPages: Int
    let totalElements: Int
    let first: Bool
    let size: Int
    let number: Int
    let sort: [Sort]
    let numberOfElements: Int
    let empty: Bool
}

// MARK: - Content
struct Content: Codable {
    let id: Int
    let userMood: String
    let clovaMood: String
    let character: String
    let date: String
}

// MARK: - Pageable
struct Pageable: Codable {
    let pageNumber: Int
    let pageSize: Int
    let sort: [Sort]
    let offset: Int
    let paged: Bool
    let unpaged: Bool
}

struct Sort: Codable {
}
