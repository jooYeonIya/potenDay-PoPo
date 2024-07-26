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
        baseView.doneButton.rx.tap
            .bind { [weak self] _ in
                self?.saveUserInfo()
            }
            .disposed(by: disposebag)
    }
    
    private func saveUserInfo() {
        let userName = baseView.nameTextField.text
        let userAge = Ages(rawValue: baseView.selecetedUserAge)?.userAsge
        let UUID = "test id"
        
        if userName == "" || baseView.selecetedUserAge == 99 {
            showAlertOneButton(title: "이름 및 나이를 확인해 주세요", message: "확인혀~")
        } else {
            let userInfo = UserInfo(age: userAge!, name: userName!, deviceId: UUID)
            ClovaAPIService.share.submitOnboard(request: userInfo)
        }
    }
    
    private func moveToHomeView() {
        let homeView = HomeViewController()
        homeView.modalPresentationStyle = .fullScreen
        present(homeView, animated: true, completion: nil)
    }
}
