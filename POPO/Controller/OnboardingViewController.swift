//
//  OnboardingViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/21/24.
//

import UIKit
import RxCocoa
import RxSwift

// 1 공통 부분 추출 혹은
// 2 페이지컨트롤러 로 변경
class OnboardingViewController: BaseViewController {
    
    lazy var baseView = OnboardingView()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.title = "행운이 찾아갈 너의 이름을 알려줘!"
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
        let viewController = OnboardingAgeViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
