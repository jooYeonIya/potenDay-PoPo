//
//  ClovaAPIService.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import Moya
import Foundation

class ClovaAPIService {
    static let share = ClovaAPIService()
    private let provider = MoyaProvider<ClovaAPI>()
    
    func checkHealth() {
        provider.request(.healthCheck) { (result) in
            switch result {
            case let .success(response):
                do {
                    if let responseString = String(data: response.data, encoding: .utf8) {
                        print("Response String: \(responseString)")
                    } else {
                        print("Failed to convert response data to string.")
                    }
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func submitDeviceId(_ deviceId: String) {
        provider.request(.myPage(deviceId: deviceId)) { (result) in
            switch result {
            case let .success(response):
                if let responseString = String(data: response.data, encoding: .utf8) {
                    print("MyPage Response: \(responseString)")
                } else {
                    print("Failed to convert response data to string.")
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 온보딩 페이지에서 사용
    func submitOnboard(request: UserInfo, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.onboard(request: request)) { result in
            switch result {
            case let .success(response):
                if let responseString = String(data: response.data, encoding: .utf8) {
                    print("Onboard Response: \(responseString)")
                } else {
                    print("Failed to convert response data to string.")
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func submitMessage(request: MessageRequest) {
        provider.request(.message(request: request)) { result in
            switch result {
            case let .success(response):
                if let responseString = String(data: response.data, encoding: .utf8) {
                    print("Onboard Response: \(responseString)")
                } else {
                    print("Failed to convert response data to string.")
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
