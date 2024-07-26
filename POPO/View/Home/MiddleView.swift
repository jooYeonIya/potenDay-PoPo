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

class MiddleView: BaseView {
    lazy var inputePlaceholderLabel = CustomLabel(text: "포포에게 알려줘!", font: .body(ofSize: 17))
    lazy var inputTextBackgroundView = UIView()
    lazy var inputTextView = UITextView()
    lazy var actionButton = UIButton()
    
    lazy var characterTextView = UITextView()
    lazy var characterImageView = UIImageView()
    lazy var speechBubbleImageView = UIImageView()
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubviews([inputTextBackgroundView,
                     actionButton,
                     speechBubbleImageView,
                     characterTextView,
                     characterImageView])
        
        setupInputTextView()
        setupCharactorView()
    }
    
    private func setupInputTextView() {
        inputePlaceholderLabel.textColor = .userGray(4)
        
        inputTextBackgroundView.addSubviews([inputTextView, actionButton])
        inputTextBackgroundView.backgroundColor = .white
        inputTextBackgroundView.layer.cornerRadius = 20
        
        inputTextView.font = .body(ofSize: 17)
        inputTextView.textColor = .userGray(1)
        inputTextView.textAlignment = .center
        inputTextView.delegate = self
        inputTextView.addSubview(inputePlaceholderLabel)
        
        toggleActionButton(.deselected)
    }

    private func setupCharactorView() {
        speechBubbleImageView.image = UIImage(named: "SpeechBalloon")
        speechBubbleImageView.addSubviews([characterTextView, characterTextView])
        
        characterImageView.image = UIImage(named: "Charactor_Main")
        
        characterTextView.text = SegmentedOption(rawValue: 0)?.description
        characterTextView.font = .point(ofSize: 15)
        characterTextView.textAlignment = .center
    }
    
    override func setupLayout() {
        inputePlaceholderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(17 / 2)
        }
        
        inputTextBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(38)
            make.height.equalTo(200)
        }
        
        inputTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.top.height.equalTo(100 - 40)
        }
        
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }

        speechBubbleImageView.snp.makeConstraints { make in
            make.top.equalTo(inputTextBackgroundView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(inputTextBackgroundView)
            make.height.equalTo(174)
            make.width.equalTo(300)
        }
        
        characterImageView.snp.makeConstraints{ make in
            make.top.equalTo(speechBubbleImageView.snp.bottom).offset(-16)
            make.trailing.equalTo(inputTextBackgroundView.snp.trailing)
            make.width.height.equalTo(100)
        }
        
        characterTextView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(120)
            make.width.equalTo(240)
        }
    }
    
    func toggleActionButton(_ option: ActionButtonOtpion) {
        switch option {
            
        case .deselected:
            let buttonOption = BasicButtonOtpion(backgroundColor: .userGray(8),
                                           borderColor: .userGray(6),
                                           fontColor: .userGray(4),
                                           text: "얍",
                                           image: UIImage(named: "Clover_Deselected")!)
            actionButton.applyBasicButton(buttonOption)
            
        case .selected:
            let buttonOption = BasicButtonOtpion(backgroundColor: .white,
                                           borderColor: .userGreen,
                                           fontColor: .userGray(1),
                                           text: "얍",
                                           image: UIImage(named: "Clover_Selected")!)
            actionButton.applyBasicButton(buttonOption)
        }
    }
    
    func updateActionButtonLoading() {
        let buttonOption = BasicButtonOtpion(backgroundColor: .userGray(8),
                                       borderColor: .userGray(6),
                                       fontColor: .userGray(4),
                                       text: "로딩중..",
                                       image: UIImage(named: "Loading")!)
        
        actionButton.applyBasicButton(buttonOption)
        actionButton.isEnabled = true
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

extension MiddleView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        inputePlaceholderLabel.isHidden = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let textIsEmpty = textView.text.isEmpty
        
        inputePlaceholderLabel.isHidden = !textIsEmpty
        
        if textIsEmpty {
            toggleActionButton(.deselected)
        } else {
            toggleActionButton(.selected)
        }
    }
}
