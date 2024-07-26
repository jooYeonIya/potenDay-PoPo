//
//  HomeView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit

class HomeView: BaseView {
    lazy var toolTip = UIImageView()
    lazy var toolTipLabel = CustomLabel(text: "비키는 원영이의 영어 이름이야!", font: .body(ofSize: 11))
    lazy var viewBlurEffect = UIVisualEffectView()
    lazy var pinkCircleView = UIView()
    lazy var greenCircleView = UIView()
    
    lazy var segmentedView = SegmentedView()
    lazy var middleView = MiddleView()
    lazy var tabBarView = TabBarView()
    lazy var moveTolackyCharmView = MoveToLackyCharmView()
    
    var vikiAnswer: String? = SegmentedOption.viki.description {
        willSet {
            middleView.characterTextView.text = newValue
        }
    }
    
    var popoAnswer: String? = SegmentedOption.popo.description {
        willSet {
            middleView.characterTextView.text = newValue
        }
    }

    override func configure() {
        super.configure()
        backgroundColor = .userGray(9)
    }
    
    override func setupUI() {
        addSubviews([pinkCircleView, greenCircleView, viewBlurEffect,
                     segmentedView, middleView, tabBarView, moveTolackyCharmView, toolTip])
        
        toolTipLabel.textColor = .userGray(4)
        toolTip.image = UIImage(named: "ToolTip")
        toolTip.isHidden = true
        toolTip.addSubview(toolTipLabel)
        
        viewBlurEffect.effect = UIBlurEffect(style: .extraLight)
        applyCircleViews()
        
        segmentedView.configure()
        middleView.configure()
        tabBarView.configure()
        moveTolackyCharmView.configure()
        moveTolackyCharmView.isHidden = true
    }
    
    private func applyCircleViews() {
        pinkCircleView.layer.cornerRadius = 411 / 2
        pinkCircleView.backgroundColor = .userPink
        
        greenCircleView.layer.cornerRadius = 411 / 2
        greenCircleView.backgroundColor = .userLightGreen
    }
    
    func updateUIForSegmentChange(_ index: Int) {
        guard let option = SegmentedOption(rawValue: index) else { return }
        
        // 메인 컴에서 퍼스트런칭 처리 넣어야함
        toolTip.isHidden = option == .viki ? false : true
        
        middleView.characterImageView.image = UIImage(named: option.imageName)
        middleView.inputePlaceholderLabel.text = "\(option.title)에게 알려줘!"
        
        switch option {
        case .popo:
            middleView.characterTextView.text = popoAnswer
        case .viki:
            middleView.characterTextView.text = vikiAnswer
        }
    }
    
    override func setupLayout() {
        toolTip.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-68)
            make.width.equalTo(180)
            make.height.equalTo(32)
        }
        
        toolTipLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(4)
        }
        
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
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(92)
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
