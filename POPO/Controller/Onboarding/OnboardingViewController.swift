//
//  OnboardingViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/24/24.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingViewController: BaseViewController {
    
    // MARK: - Component
    lazy var baseView = OnboardingView()
    
    private let disposebag = DisposeBag()
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
    
    override func setupEvent() {
        baseView.doneButton.rx
            .tap
            .bind { [weak self] _ in
                self?.saveUserInfo()
            }
            .disposed(by: disposebag)
        
//        baseView.nameTextField.rx
//            
    }
    
    // 유저 정보 등록
    private func saveUserInfo() {
        let userName = baseView.nameTextField.text
        let userAge = Ages(rawValue: baseView.selecetedUserAge)?.userAsge
        let UUID = UUID().uuidString
        
        if userName == "" || baseView.selecetedUserAge == 99 {
            showAlertOneButton(title: "이름 및 나이를 확인해 주세요", message: "확인혀~")
        } else {
//            let userInfo = UserInfoRequest(age: userAge!, name: userName!, deviceId: UUID)
//            ClovaAPIService.share.saveUserInfo(request: userInfo) { result in
//                switch result {
//                case .success(_):
                    UserDefaults.standard.setValue(UUID, forKey: "deviceId")
                    self.moveToHomeView()
//                case .failure(_):
//                    self.showAlertOneButton(title: "", message: "다시 한 번 시도해 주세요")
//                }
//            }
        }
    }
    
    private func moveToHomeView() {        
        UserDefaults.standard.setValue(true, forKey: "isOnboardingCompleted")
        UserDefaults.standard.setValue(false, forKey: "isHomeToolTipShow")


        let homeViewController = HomeViewController()
        let navigationController = UINavigationController(rootViewController: homeViewController)
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
    }
}
