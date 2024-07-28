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
    case getMyPageMessage(deviceId: String, page: Int, size: Int)
    case saveUserInfo(request: UserInfoRequest)
    case getAnswer(request: MessageRequest)
    case makeCharm(request: CharmRequest)
    case modifyNickname(request: ModifyNicknameRequest)
}

extension ClovaAPI: TargetType {
    var baseURL: URL {
        return URL(string: "http://223.130.162.220:8080")!
    }
    
    var path: String {
        switch self {
        case .getUserInfo(deviceId: _):
            return "/onboard"
        case .getMyPageMessage:
            return "/my-page"
        case .saveUserInfo(request: _):
            return "/onboard"
        case .getAnswer(request: _):
            return "/message"
        case .makeCharm:
            return "/charm"
        case .modifyNickname(request: _):
            return "/my-page/name"
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
        case .modifyNickname(request: _):
            return .patch
        }
    }
    
    var task: Task {
        switch self {
        case let .getUserInfo(deviceId):
            return .requestParameters(parameters: ["deviceId": deviceId], encoding: URLEncoding.queryString)
        case let .getMyPageMessage(deviceId, page, size):
            return .requestParameters(parameters: ["deviceId": deviceId, "page": page, "size": size], encoding: URLEncoding.queryString)
        case let .saveUserInfo(request):
            return .requestJSONEncodable(request)
        case let .getAnswer(request):
            return .requestJSONEncodable(request)
        case let .makeCharm(request):
            return .requestJSONEncodable(request)
        case let .modifyNickname(request):
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
