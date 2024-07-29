//
//  ViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/21/24.
//

import UIKit
import SnapKit

class LaunchScreenViewController: UIViewController {
    
    // 컴포넌트
    lazy var topLogoImageView = CustomImageView("NaverLogo")
    lazy var titleLabel = CustomLabel(text: "PoPo", font: .point(ofSize: 40))
    lazy var subTitleLabel = CustomLabel(text: "클로바가 말아주는 클로버🍀", 
                                         font: .point(ofSize: 15),
                                         fontColor: .userGray(4))
    lazy var moveToNextViewButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    // Setup UI
    private func setupUI() {
        view.backgroundColor = .userLightGreen
        view.addSubviews([topLogoImageView, titleLabel, subTitleLabel, moveToNextViewButton])

        moveToNextViewButton.addTarget(self, action: #selector(moveToNextViewButtonTapped), for: .touchUpInside)
        moveToNextViewButton.applyBlurButton(withImage: UIImage(named: "Clover_Selected")!,
                                             withText: "무엇이든 긍정적으로 바꿔봐!", fontSize: 15)
        
        applyRadialGradientBackground()
    }
    
    // 메소드
    private func applyRadialGradientBackground() {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.setNeedsDisplay()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc private func moveToNextViewButtonTapped() {
        let isOnboardingCompleted = UserDefaults.standard.bool(forKey: "isOnboardingCompleted")
        
        if isOnboardingCompleted {
            let tabBarViewController = CustomTabBarViewController()
            tabBarViewController.modalPresentationStyle = .fullScreen
            present(tabBarViewController, animated: false)
        } else {
            let onboardingViewController = OnboardingViewController()
            onboardingViewController.modalPresentationStyle = .fullScreen
            present(onboardingViewController, animated: false)
        }
    }
    
    // Setup Layout
    private func setupLayout() {
        topLogoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        moveToNextViewButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}

class RadialGradientLayer: CALayer {
    override func draw(in ctx: CGContext) {
        let colors = [UIColor.white.cgColor, // 중앙 색상
                      UIColor.userLightGreen.cgColor] // 외곽 색상

        // RGB 색상 공간 생성
        let colorSpace = CGColorSpaceCreateDeviceRGB()

        // 색상 위치 배열 (0.0 = 중앙, 1.0 = 외곽)
        let colorLocations: [CGFloat] = [0.0, 1.0]

        // 색상 공간과 색상 배열로 그라데이션 객체 생성
        guard let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: colorLocations) else {
            return
        }

        // 그라데이션의 중심점 설정
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        
        // 그라데이션의 반지름 설정
        let radius = 334

        ctx.drawRadialGradient(gradient,
                               startCenter: center, startRadius: 0, // 시작점과 시작 반지름 설정
                               endCenter: center, endRadius: CGFloat(radius), // 끝점과 끝 반지름 설정
                               options: .drawsAfterEndLocation) // 그라데이션 옵션 설정
    }
}
