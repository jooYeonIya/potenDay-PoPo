//
//  HomeView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit

class HomeView: BaseView {
    lazy var pinkCircleView = UIView()
    lazy var greenCircleView = UIView()
    
    lazy var viewBlurEffect = UIVisualEffectView()

    override func configure() {
        super.configure()
        backgroundColor = .userGray(9)
    }
    
    override func setupUI() {
        addSubviews([pinkCircleView, greenCircleView, viewBlurEffect])
        
        viewBlurEffect.effect = UIBlurEffect(style: .light)
        
        applyCircleViews()
    }
    
    private func applyCircleViews() {
        pinkCircleView.layer.cornerRadius = 411 / 2
        pinkCircleView.backgroundColor = .userPink
        
        greenCircleView.layer.cornerRadius = 411 / 2
        greenCircleView.backgroundColor = .userLightGreen
    }
    
    override func setupLayout() {
        viewBlurEffect.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pinkCircleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.equalToSuperview().offset(100)
            make.width.height.equalTo(411)
        }
        
        greenCircleView.snp.makeConstraints { make in
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
            make.trailing.equalToSuperview().offset(-100)
            make.width.height.equalTo(411)
        }
    }
}
