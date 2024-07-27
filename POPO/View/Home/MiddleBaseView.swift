//
//  MiddleView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit
import SnapKit

enum ActionButtonOtpion: Int {
    case selected
    case deselected
}

class MiddleBaseView: BaseView {
    
    // Input 창
    lazy var inputTextViewBackgroundView = UIView()
    lazy var inputTextViewPlaceholderLabel = UILabel()
    lazy var inputTextView = UITextView()
    
    // Output 창
    lazy var outPutSpeechBalloonImageView = UIImageView()
    lazy var outPutTextView = UITextView()
    lazy var outPutCharacterImageView = UIImageView()
    
    
    // 얍 버튼
    lazy var actionButton = UIButton()
    
    var option: SegmentedOption?
    
    init(option: SegmentedOption?) {
        self.option = option
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubviews([inputTextViewBackgroundView,
                     outPutSpeechBalloonImageView,
                     outPutCharacterImageView])
        
        setupInputTextView()
        setupOutputView()
    }
    
    // Input 창
    private func setupInputTextView() {
        inputTextViewBackgroundView.addSubviews([inputTextView, actionButton])
        inputTextViewBackgroundView.backgroundColor = .white
        inputTextViewBackgroundView.layer.cornerRadius = 20
        
        inputTextViewPlaceholderLabel.text = "\(option?.title ?? "포포")에게 알려줘!"
        inputTextViewPlaceholderLabel.textColor = .userGray(4)
        inputTextViewPlaceholderLabel.font = .body(ofSize: 17)
        
        inputTextView.addSubview(inputTextViewPlaceholderLabel)
        inputTextView.font = .body(ofSize: 17)
        inputTextView.textColor = .userGray(1)
        inputTextView.textAlignment = .center
        inputTextView.delegate = self
        
        toggleActionButton(.deselected)
    }

    // Output 창
    private func setupOutputView() {
        guard let option = option else { return }
        
        outPutSpeechBalloonImageView.addSubviews([outPutTextView])
        outPutSpeechBalloonImageView.image = UIImage(named: "SpeechBalloon")
        
        outPutCharacterImageView.image = UIImage(named: option.imageName)
        
        outPutTextView.text = SegmentedOption(rawValue: option.rawValue)?.description
        outPutTextView.font = .point(ofSize: 15)
        outPutTextView.textAlignment = .center
    }
    
    override func setupLayout() {
        // Input 창 (+ acitonButton)
        inputTextViewBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(38)
            make.height.equalTo(200)
        }
        
        inputTextViewPlaceholderLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    
        inputTextView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(100)
        }
        
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }

        // Output 창
        outPutSpeechBalloonImageView.snp.makeConstraints { make in
            make.top.equalTo(inputTextViewBackgroundView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(inputTextViewBackgroundView)
            make.height.equalTo(174)
            make.width.equalTo(300)
        }
        
        outPutTextView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(240)
        }
        
        outPutCharacterImageView.snp.makeConstraints{ make in
            make.top.equalTo(outPutSpeechBalloonImageView.snp.bottom).offset(-16)
            make.trailing.equalTo(inputTextViewBackgroundView.snp.trailing)
            make.width.height.equalTo(100)
        }
    }
    
    // 버튼 관련 함수들
    func toggleActionButton(_ option: ActionButtonOtpion) {
        switch option {
            
        case .deselected:
            let buttonOption = BasicButtonOtpion(backgroundColor: .userGray(8),
                                           borderColor: .userGray(6),
                                           fontColor: .userGray(4),
                                           text: "얍",
                                           image: UIImage(named: "Clover_Deselected")!)
            actionButton.applyBasicButton(buttonOption)
            actionButton.isEnabled = false
            
        case .selected:
            let buttonOption = BasicButtonOtpion(backgroundColor: .white,
                                           borderColor: .userGreen,
                                           fontColor: .userGray(1),
                                           text: "얍",
                                           image: UIImage(named: "Clover_Selected")!)
            actionButton.applyBasicButton(buttonOption)
            actionButton.isEnabled = true
        }
    }
    
    func updateActionButtonLoading() {
        let buttonOption = BasicButtonOtpion(backgroundColor: .userGray(8),
                                       borderColor: .userGray(6),
                                       fontColor: .userGray(4),
                                       text: "로딩중..",
                                       image: UIImage(named: "Loading")!)
        
        actionButton.applyBasicButton(buttonOption)
        actionButton.isEnabled = false
    }
    
    func updateAcionButtonRepeat() {
        let buttonOption = BasicButtonOtpion(backgroundColor: .white,
                                       borderColor: .userGreen,
                                       fontColor: .userGray(1),
                                       text: "다시하기",
                                       image: UIImage(named: "Clover_Selected")!)
        actionButton.applyBasicButton(buttonOption)
        actionButton.isEnabled = true
    }
}

extension MiddleBaseView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        inputTextViewPlaceholderLabel.isHidden = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textIsEmpty = textView.text.isEmpty
        
        inputTextViewPlaceholderLabel.isHidden = !textIsEmpty
        
        if textIsEmpty {
            toggleActionButton(.deselected)
        } else {
            toggleActionButton(.selected)
        }
    }
}
