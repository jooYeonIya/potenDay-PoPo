//
//  ClovaAPI.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import Moya
import Foundation

enum ClovaAPI {
    case getUserInfo(deviceId: String)
    case getMyPageMessage(deviceId: String)
    case saveUserInfo(request: UserInfo)
    case getAnswer(request: MessageRequest)
    case makeCharm(request: CharmReponse)
}

extension ClovaAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://223.130.162.220:8080")!
    }
    
    var path: String {
        switch self {
        case .getUserInfo(deviceId: _):
            return "/onboard"
        case .getMyPageMessage(deviceId: _):
            return "/my-page"
        case .saveUserInfo(request: _):
            return "/onboard"
        case .getAnswer(request: _):
            return "/message"
        case .makeCharm:
            return "/charm"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getUserInfo:
            return .get
        case .getMyPageMessage:
            return .get
        case .saveUserInfo(request: _):
            return .post
        case .getAnswer(request: _):
            return .post
        case .makeCharm(request: _):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case let .getUserInfo(deviceId):
            return .requestParameters(parameters: ["deviceId": deviceId], encoding: URLEncoding.queryString)
        case let .getMyPageMessage(deviceId):
            return .requestParameters(parameters: ["diviceId": deviceId], encoding: URLEncoding.queryString)
        case let .saveUserInfo(request):
            return .requestJSONEncodable(request)
        case let .getAnswer(request):
            return .requestJSONEncodable(request)
        case let .makeCharm(request):
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
