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
    
    // 사용자 정보 조회
    func fetchUserInfo(deviceId: String, completion: @escaping (Result<UserInfoReponse, Error>) -> Void) {
        provider.request(.getUserInfo(deviceId: deviceId)) { result in
            switch result {
            case let .success(response):
                do {
                    let userInfoResponse = try JSONDecoder().decode(UserInfoReponse.self, from: response.data)
                    completion(.success(userInfoResponse))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    // 마이페이지 메시지 조회
    func fetchMyPageMessage(deviceId:String, completion: @escaping (Result<MessageResponse, Error>) -> Void) {
        provider.request(.getMyPageMessage(deviceId: deviceId)) { result in
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
    
    // 온보딩 화면에서 유저정보 저장
    func saveUserInfo(request: UserInfoRequest, completion: @escaping (Result<String, Error>) -> Void) {
        provider.request(.saveUserInfo(request: request)) { result in
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
    
    // 포포 비키 대답 받는 함수
    func submitMessage(request: MessageRequest, completion: @escaping (Result<MessageResponse, Error>) -> Void) {
        provider.request(.getAnswer(request: request)) { result in
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
    func fetchCharm(request: CharmRequest, completion: @escaping (Result<CharmReponse, Error>) -> Void) {
        provider.request(.makeCharm(request: request)) { result in
            switch result {
            case let .success(response):
                do {
                    let charmResponse = try JSONDecoder().decode(CharmReponse.self, from: response.data)
                    completion(.success(charmResponse))
                } catch {
                    completion(.failure(error))
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
