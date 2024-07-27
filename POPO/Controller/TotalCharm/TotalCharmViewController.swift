//
//  TotalCharmViewController.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class TotalCharmViewController: BaseViewController {
    
    lazy var baseView = TotalCharmView()

    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.configure()
        baseView.delegate = self
        baseView.getImagesFromFolder()
    }
}

extension TotalCharmViewController: TotalCharmViewDelegate {
    func moveToView(index: Int) {
        let option = TabBarOption(rawValue: index)
        
        switch option {
        case .totalCharm:
            let homeViewController = TotalCharmViewController()
            let navigationController = UINavigationController(rootViewController: homeViewController)
            
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
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
    
    func moveToMakeCharmView(image: UIImage) {
        let vc = MakeCharmViewController(answer: "total", image: image)
        navigationController?.pushViewController(vc, animated: true)
    }
}
