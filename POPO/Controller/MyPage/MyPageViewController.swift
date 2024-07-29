//
//  MyPageViewController.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class MyPageViewController: BaseViewController, UserInfoViewDelegate {
    lazy var baseView = MyPageView()

    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.configure()
        baseView.userInfoView.delegate = self
        
        fetchUserInfo()
        fetchMessage()
    }
    
    func fetchUserInfo() {
//        guard let deviceId = UserDefaults.standard.string(forKey: "deviceId") else { return }
//        ClovaAPIService.share.fetchUserInfo(deviceId: deviceId) { result in
//            switch result {
//            case .success(let response):
//                self.baseView.userInfoView.nicknameTextField.text = response.data.name
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        baseView.userInfoView.nameTextField.text = "테스트 Id"
    }
    
    func modifyName() {
        guard let newName = baseView.userInfoView.nameTextField.text,
              let deviceId = UserDefaults.standard.string(forKey: "deviceId") else { return }
        let newUserInfo = ModifyNicknameRequest(name: newName, deviceId: deviceId)
        
//        ClovaAPIService.share.modifyName(request: newUserInfo) { result in
//            switch result {
//            case .success(_):
                self.fetchUserInfo()
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
    
    func fetchMessage() {
        guard let deviceId = UserDefaults.standard.string(forKey: "deviceId") else { return }

//        ClovaAPIService.share.fetchMyPageMessage(deviceId: deviceId) { result in
//            switch result {
//            case .success(let response):
//                let contents = response.data?.content
//                self.baseView.contents = contents ?? []
//                print(response)
//            case .failure(let error):
//                print(error)
//            }
//        }
        let contents = [Content(id: 1,
                               userMood: "테스트 중",
                               clovaMood: "테스트 중",
                               character: "포포",
                               date: "9999-01-01")]
        
        baseView.contents = contents
    }
}
