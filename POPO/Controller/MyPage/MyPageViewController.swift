//
//  MyPageViewController.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class MyPageViewController: BaseViewController {
    
    lazy var baseView = MyPageView()

    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.configure()
        baseView.delegate = self
        
        guard let deviceId = UserDefaults.standard.string(forKey: "deviceId") else { return }
        ClovaAPIService.share.fetchUserInfo(deviceId: deviceId) { result in
            switch result {
            case .success(let response):
                self.baseView.userInfoView.nicknameTextField.text = response.data.name
            case .failure(let error):
                print(error)
            }
        }
        
//        ClovaAPIService.share.fetchMyPageMessage(deviceId: deviceId) { result in
//            print(result)
//        }
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
            let vc = HomeViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        case .myPage:
            let vc = MyPageViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        case .none: break
        }
    }
}
