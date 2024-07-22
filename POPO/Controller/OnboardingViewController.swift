//
//  OnboardingViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/21/24.
//

import UIKit

class OnboardingViewController: BaseViewController {
    
    lazy var baseView = OnboardingView()
    
    override func loadView() {
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
}
