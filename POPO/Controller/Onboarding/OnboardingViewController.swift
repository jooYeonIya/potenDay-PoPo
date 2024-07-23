//
//  OnboardingViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/24/24.
//

import UIKit

class OnboardingViewController: BaseViewController {
    
    // MARK: - Component
    lazy var baseView = OnboardingView()
    
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
}
