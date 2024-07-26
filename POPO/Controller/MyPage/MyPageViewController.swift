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
