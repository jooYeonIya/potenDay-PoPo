//
//  HomeView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    func moveToView(index: Int)
}

class HomeView: BaseView {
    // 바탕 구성
    lazy var viewBlurEffect = UIVisualEffectView()
    lazy var circleView = UIView()
    
    lazy var segmentedView = SegmentedView()
    lazy var middleView = MiddleView()
    lazy var tabBarView = TabBarView(selectedIndex: TabBarOption.home.rawValue)
    lazy var moveTolackyCharmView = MoveToLackyCharmView()
    
    weak var delegate: HomeViewDelegate?
    
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
        addSubviews([circleView, viewBlurEffect,
                     segmentedView, middleView, tabBarView, moveTolackyCharmView])
        
        viewBlurEffect.effect = UIBlurEffect(style: .extraLight)
        applyCircleViews()
        
        segmentedView.configure()
        middleView.configure()
        tabBarView.delegate = self
        
        moveTolackyCharmView.configure()
        moveTolackyCharmView.isHidden = false
    }
    
    private func applyCircleViews() {
        circleView.layer.cornerRadius = 411 / 2
        circleView.backgroundColor = .userPink
    }
    
    func updateUIForSegmentChange(_ index: Int) {
        guard let option = SegmentedOption(rawValue: index) else { return }
                
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
        viewBlurEffect.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        circleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.leading.equalToSuperview().offset(100)
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

extension HomeView: TabBarViewDelegate {
    func tabBarButtonTapped(index: Int) {
        delegate?.moveToView(index: index)
    }
}
