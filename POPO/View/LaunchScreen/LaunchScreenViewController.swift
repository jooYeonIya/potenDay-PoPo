//
//  ViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/21/24.
//

import UIKit
import SnapKit

class LaunchScreenViewController: UIViewController {
    
    // MARK: - Component
    lazy var captionLable = CustomLabel(text: "Powered by HyperCLOVA X", font: .body(ofSize: 11))
    lazy var titleLabel = CustomLabel(text: "PoPo", font: .point(ofSize: 40))
    lazy var subTitleLabel = CustomLabel(text: "클로바가 말아주는 클로버🍀", font: .point(ofSize: 15))
    lazy var button = UIButton()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
    }
    
    // MARK: - Method
    private func setupUI() {
        
        view.addSubviews([captionLable, titleLabel, subTitleLabel, button])
        
        captionLable.textColor = .userGray(6)
        subTitleLabel.textColor = .userGray(4)
        
        button.applyBlurButton(withImage: UIImage(named: "Clover")!, withText: "무엇이든 긍정적으로 바꿔봐!", fontSize: 15)
        button.addTarget(self, action: #selector(moveToNextView), for: .touchUpInside)        
        
        applyRadialGradientBackground()
    }
    
    private func setupLayout() {
        captionLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }

    private func applyRadialGradientBackground() {
        let gradientLayer = RadialGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.setNeedsDisplay()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc private func moveToNextView() {
        // 첫 실행인지 아닌지에 따라서 뷰 이동 따로따로 해야함
        
        // 첫 실행 시 - 온보딩 뷰
        let onboardingView = OnboardingViewController()
        onboardingView.modalPresentationStyle = .fullScreen
        present(onboardingView, animated: true, completion: nil)
    }
}

class RadialGradientLayer: CALayer {
    override func draw(in ctx: CGContext) {
        let colors = [UIColor.userPink.cgColor, // 중앙 색상
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
