//
//  ClovaAPI.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import Moya
import Foundation

enum ClovaAPI {
    case healthCheck
    case myPage(deviceId: String)
    case onboard(request: UserInfo)
    case message(request: MessageRequest)
}

extension ClovaAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://223.130.162.220:8080")!
    }
    
    var path: String {
        switch self {
        case .healthCheck:
            return "/health-check"
        case .myPage(deviceId: _):
            return "/my-page"
        case .onboard(request: _):
            return "/onboard"
        case .message(request: _):
            return "/message"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .healthCheck, .myPage(deviceId: _):
            return .get
        case .onboard(request: _), .message(request: _):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .healthCheck:
            return .requestPlain
        case let .myPage(deviceId):
            return .requestParameters(parameters: ["dId": deviceId], encoding: URLEncoding.queryString)
        case let .onboard(request):
            return .requestJSONEncodable(request)
        case let .message(request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var sampleData: Data {
        return Data()
    }
}
