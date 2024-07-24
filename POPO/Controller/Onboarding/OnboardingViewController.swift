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
                self?.moveToHomeView()
            }
            .disposed(by: disposebag)
    }
    
    private func moveToHomeView() {
        let homeView = HomeViewController()
        homeView.modalPresentationStyle = .fullScreen
        present(homeView, animated: true, completion: nil)
    }
}
