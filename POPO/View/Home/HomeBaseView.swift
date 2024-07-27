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

class HomeBaseView: BaseView {
    // 바탕 구성
    lazy var viewBlurEffect = UIVisualEffectView()
    lazy var circleView = UIView()
    
    // 세그먼티드 컨트롤 뷰
    lazy var segmentedView = SegmentedView()
    
    // 비키 툴틉
    lazy var toolTipView = UIImageView()
    lazy var toolTipViewTextLabel = CustomLabel(text: "비키는 여기서 만날 수 있어!", font: .body(ofSize: 11))
    
    // 미들 뷰 - input, output
    var middleView: MiddleBaseView!
    
    // 부적 만들기로 이동하는 버튼 뷰
    lazy var moveToMakeCharmButtonView = MoveToLackyCharmView()
    
    // tabbar
    lazy var tabBarView = TabBarView(selectedIndex: TabBarOption.home.rawValue)
    
    
    // 변수
    weak var delegate: HomeViewDelegate?
    var option: SegmentedOption?
    var answer: String? = SegmentedOption.viki.description {
        willSet {
            middleView.outPutTextView.text = newValue
        }
    }
    
    init(option: SegmentedOption?) {
        self.option = option
        self.middleView = MiddleBaseView(option: option)
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubviews([circleView, 
                     viewBlurEffect,
                     segmentedView, 
                     toolTipView,
                     middleView,
                     moveToMakeCharmButtonView,
                     tabBarView])
        
        // 바탕 구성
        backgroundColor = .userGray(9)
        applyCircleView(option?.circleColor ?? UIColor.userLightGreen)
        viewBlurEffect.effect = UIBlurEffect(style: .extraLight)
        
        // 세그먼티드 컨트롤 뷰
        segmentedView.configure()
        
        // 툴팁 뷰
        toolTipView.image = UIImage(named: "PinkToolTip")
        toolTipView.addSubview(toolTipViewTextLabel)
        
        // 미들 뷰 - input, output
        middleView.configure()
        
        // 부적 만들기로 이동하는 버튼 뷰
        moveToMakeCharmButtonView.configure()
        moveToMakeCharmButtonView.isHidden = false
        
        // tabbar
        tabBarView.delegate = self
    }
    
    private func applyCircleView(_ color: UIColor) {
        circleView.layer.cornerRadius = 580 / 2
        circleView.backgroundColor = color
    }
    
    func updateUIForSegmentChange(_ index: Int) {
        guard let option = SegmentedOption(rawValue: index) else { return }
        circleView.backgroundColor = option.circleColor
        
        middleView.option = option
        middleView.configure()
    }
    
    override func setupLayout() {
        circleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(580)
        }
        
        viewBlurEffect.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        segmentedView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(92)
        }
        
        toolTipView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-92)
        }
        
        toolTipViewTextLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(4)
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(segmentedView.snp.bottom).offset(54)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(moveToMakeCharmButtonView.snp.top)
        }
        
        moveToMakeCharmButtonView.snp.makeConstraints { make in
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

extension HomeBaseView: TabBarViewDelegate {
    func tabBarButtonTapped(index: Int) {
        delegate?.moveToView(index: index)
    }
}
