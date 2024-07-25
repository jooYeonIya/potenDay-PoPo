//
//  HomeView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit

class HomeView: BaseView {
    lazy var viewBlurEffect = UIVisualEffectView()
    lazy var pinkCircleView = UIView()
    lazy var greenCircleView = UIView()
    
    lazy var segmentedView = SegmentedView()
    lazy var middleView = MiddleView()
    lazy var tabBarView = TabBarView()
    lazy var moveTolackyCharmView = MoveToLackyCharmView()

    override func configure() {
        super.configure()
        backgroundColor = .userGray(9)
    }
    
    override func setupUI() {
        addSubviews([pinkCircleView, greenCircleView, viewBlurEffect, 
                     segmentedView, middleView, tabBarView, moveTolackyCharmView])
        
        viewBlurEffect.effect = UIBlurEffect(style: .light)
        applyCircleViews()
        
        segmentedView.configure()
        middleView.configure()
        tabBarView.configure()
        moveTolackyCharmView.configure()
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
        
        segmentedView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(120)
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom).offset(54)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        moveTolackyCharmView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBarView.snp.top).offset(-16)
            make.height.equalTo(40)
        }
        
        tabBarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(80)
        }
    }
}
