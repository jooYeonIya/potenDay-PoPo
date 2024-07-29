//
//  CustomTabBarViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/29/24.
//

import UIKit
import SnapKit

class CustomTabBarViewController: BaseViewController, TabBarViewDelegate {
    
    let tabBarView = CustomTabBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .userGray(9)
        view.addSubview(tabBarView)
        
        setupTabBarView()
        
        tabBarButtonTapped(option: .home)
    }
    
    func setupTabBarView() {
        tabBarView.configure()
        tabBarView.selectedIndex = TabBarOption.home.rawValue
        tabBarView.delegate = self
        
        tabBarView.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(80)
        }
    }
    
    func tabBarButtonTapped(option: TabBarOption) {
        switch option {
        case .totalCharm: moveToTotalCharmView()
        case .home: moveToHomeView()
        case .myPage: moveToMyPageView()
        }
    }
    
    func moveToTotalCharmView() {
        let VC = TotalCharmViewController()
        let naviVC = UINavigationController(rootViewController: VC)
        moveToView(VC: naviVC)
    }
    
    func moveToHomeView() {
        let VC = HomeViewController()
        let naviVC = UINavigationController(rootViewController: VC)
        moveToView(VC: naviVC)
    }
    
    func moveToMyPageView() {
        let VC = MyPageViewController()
        let naviVC = UINavigationController(rootViewController: VC)
        moveToView(VC: naviVC)
    }
    
    func moveToView(VC: UIViewController) {
        for child in children {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
        
        addChild(VC)
        view.addSubview(VC.view)
        VC.didMove(toParent: self)
        
        VC.view.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBarView.snp.top)
        }
    }
}
