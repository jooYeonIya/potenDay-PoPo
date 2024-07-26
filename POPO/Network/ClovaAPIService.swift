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
    
    // 응원 메세지 받는 함수 - 홈 화면에서 사용
    func submitMessage(request: MessageRequest, completion: @escaping (Result<MessageResponse, Error>) -> Void) {
        provider.request(.message(request: request)) { result in
            switch result {
            case let .success(response):
                do {
                    let messageResponse = try JSONDecoder().decode(MessageResponse.self, from: response.data)
                    completion(.success(messageResponse))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 부적 만들기에서 사용
    func fetchCharm(completion: @escaping (Result<CharmReponse, Error>) -> Void) {
        provider.request(.charm) { result in
            switch result {
            case let .success(response):
                do {
                    let charm = try JSONDecoder().decode(CharmReponse.self, from: response.data)
                    completion(.success(charm))
                } catch {
                    completion(.failure(error))
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
