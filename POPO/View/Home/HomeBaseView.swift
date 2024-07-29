//
//  HomeView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit

class HomeBaseView: BaseView {
    // 바탕 구성
    lazy var viewBlurEffect = UIVisualEffectView()
    lazy var circleView = UIView()
    
    // 세그먼티드 컨트롤 뷰
    lazy var segmentedControl: UISegmentedControl = {
        let items = [SegmentedOption.popo.title, SegmentedOption.viki.title]
        let segmentedControl = UISegmentedControl(items: items)
        return segmentedControl
    }()
    
    // 비키 툴틉
    lazy var toolTipView = CustomImageView("PinkToolTip")
    lazy var toolTipViewTextLabel = CustomLabel(text: "비키는 여기서 만날 수 있어!", font: .body(ofSize: 11))
    
    // 미들 뷰 - input, output
    var middleView: MiddleBaseView!
    
    // 부적 만들기로 이동하는 버튼 뷰
    lazy var moveToMakeCharmViewButton = UIButton()

    // 변수
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
        backgroundColor = .userGray(9)
    }
    
    override func setupUI() {
        addSubviews([circleView,
                     viewBlurEffect,
                     segmentedControl,
                     toolTipView,
                     middleView,
                     moveToMakeCharmViewButton])
        
        // 바탕 구성
        circleView.createCircleView(option?.circleColor ?? .userLightGreen)
        viewBlurEffect.effect = UIBlurEffect(style: .extraLight)
        
        // 세그먼티드 뷰
        setupSegmentedControl()
        
        // 툴팁 뷰
        toolTipView.addSubview(toolTipViewTextLabel)
        
        // 미들 뷰 - input, output
        middleView.configure()
        
        // 부적 만들기로 이동하는 버튼 뷰
        setupButton()
    }

    private func setupSegmentedControl() {
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .userLightGreen
        segmentedControl.selectedSegmentTintColor = .white

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.body(ofSize: 17),
            .foregroundColor: UIColor.userGray(4)
        ]
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.bodyBold(ofSize: 17),
            .foregroundColor: UIColor.userGreen
        ]
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
    }
    
    private func setupButton() {
        let buttonOption = BasicButtonOtpion(backgroundColor: .white,
                                             borderColor: .userGray(1),
                                             fontColor: .userGray(1),
                                             text: "부적으로 행운을 빌어줄게!",
                                             image: UIImage(named: "DoneButton")!)
        moveToMakeCharmViewButton.applyBasicButton(buttonOption)
        moveToMakeCharmViewButton.isHidden = true
    }
    
    func updateUIForSegmentChange(_ index: Int) {
        guard let option = SegmentedOption(rawValue: index) else { return }
        circleView.backgroundColor = option.circleColor
        middleView.option = option
        middleView.configure()
        
        let buttonOption = middleView.inputTextViewPlaceholderLabel.isHidden 
            ? ActionButtonOtpion.selected : ActionButtonOtpion.deselected
        middleView.toggleActionButton(buttonOption)
    }
    
    override func setupLayout() {
        circleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(580)
        }
        
        viewBlurEffect.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalTo(92)
        }
        
        toolTipView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-92)
        }
        
        toolTipViewTextLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(4)
        }
        
        middleView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(54)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(moveToMakeCharmViewButton.snp.top)
        }
        
        moveToMakeCharmViewButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
    }
}
