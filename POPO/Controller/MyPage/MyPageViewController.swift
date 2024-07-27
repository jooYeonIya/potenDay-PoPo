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
        baseView.delegate = self
        baseView.userInfoView.delegate = self
        
        fetchUserInfo()
        fetchMessage()
    }
    
    func fetchUserInfo() {
        guard let deviceId = UserDefaults.standard.string(forKey: "deviceId") else { return }
        ClovaAPIService.share.fetchUserInfo(deviceId: deviceId) { result in
            switch result {
            case .success(let response):
                self.baseView.userInfoView.nicknameTextField.text = response.data.name
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func modifyName() {
        guard let newName = baseView.userInfoView.nicknameTextField.text,
              let deviceId = UserDefaults.standard.string(forKey: "deviceId") else { return }
        let newUserInfo = ModifyNicknameRequest(name: newName, deviceId: deviceId)
        
        ClovaAPIService.share.modifyName(request: newUserInfo) { result in
            switch result {
            case .success(_):
                self.fetchUserInfo()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchMessage() {
        guard let deviceId = UserDefaults.standard.string(forKey: "deviceId") else { return }

        ClovaAPIService.share.fetchMyPageMessage(deviceId: deviceId) { result in
            switch result {
            case .success(let response):
                let contents = response.data?.content
                self.baseView.contents = contents ?? []
                print(response)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension MyPageViewController: MyPageViewDelegate {
    func moveToView(index: Int) {
        let option = TabBarOption(rawValue: index)
        
        switch option {
        case .totalCharm:
            let vc = TotalCharmViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        case .home:
            let homeViewController = HomeViewController()
            let navigationController = UINavigationController(rootViewController: homeViewController)
            
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        case .myPage:
            let vc = MyPageViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        case .none: break
        }
    }
}
