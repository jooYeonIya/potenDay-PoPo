//
//  OnboardingAgeViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/21/24.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingAgeViewController: BaseViewController {
    
    lazy var baseView = OnboardingView()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.title = "연령대도 알려줘!"
        baseView.configure()
    }
    
    override func setupEvent() {
        baseView.nextButton.rx.tap
            .bind { [weak self] _ in
                self?.moveToNextView()
            }
            .disposed(by: disposeBag)
    }
    
    private func moveToNextView() {
        print("ASf")
    }
}
