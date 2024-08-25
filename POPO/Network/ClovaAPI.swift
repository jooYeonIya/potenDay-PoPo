//
//  ClovaAPI.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import Moya
import Foundation

enum ClovaAPI {
    // 사용자 정보 불러오기
    case getUserInfo(deviceId: String)
    
    // 사용자 마이 페이지의 메세지 불러오기
    case getMyPageMessage(deviceId: String, page: Int, size: Int)
    
    // 사용자 등록하기
    case saveUserInfo(request: UserInfoRequest)
    
    // 포포, 비키 답변 불러오기
    case getAnswer(request: String)
    
    // 부적 만들기 메세기 불러오기
    case getCharmMessage(request: CharmRequest)
    
    // 사용자 이름 변경하기
    case modifyUserName(request: ModifyNicknameRequest)
}

extension ClovaAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.openai.com/v1")!
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
            return "/chat/completions"
        case .getCharmMessage:
            return "/charm"
        case .modifyUserName(request: _):
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
        case .getCharmMessage(request: _):
            return .post
        case .modifyUserName(request: _):
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
            let parameters: [String: Any] = [
                "model": "gpt-4o",
                "messages": [
                    ["role": "system", "content": "You are a helpful assistant."],
                    ["role": "user", "content": request]
                    ],
                "max_tokens": 150
            ]
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case let .getCharmMessage(request):
            return .requestJSONEncodable(request)
        case let .modifyUserName(request):
            return .requestJSONEncodable(request)
        }
    }
    
    var headers: [String: String]? {
        let apiKey = getAPIKeyFromInfoPlist()
        return [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(apiKey)"
        ]
    }
    
    var sampleData: Data {
        return Data()
    }
    
    private func getAPIKeyFromInfoPlist() -> String {
        return Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String ?? ""
    }
}
