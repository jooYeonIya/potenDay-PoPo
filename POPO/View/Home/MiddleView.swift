//
//  MiddleView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit
import SnapKit

class MiddleView: BaseView {
    lazy var inputePlaceholderLabel = CustomLabel(text: "포포한테 알려줘", font: .body(ofSize: 17))
    lazy var inputTextBackgroundView = UIView()
    lazy var inputTextView = UITextView()
    lazy var actionButton = UIButton()
    lazy var characterTextView = UITextView()
    lazy var characterImageView = UIImageView()
    lazy var speechBubble = UIImageView()
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubviews([inputTextBackgroundView,
                     actionButton,
                     characterTextView,
                     characterImageView])
        
        setupInputTextView()
        setupActionButton()
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
    }
    
    private func setupActionButton() {
        actionButton.applyDeselectedButton(withImgae: UIImage(named: "DeselectedClover")!,
                                           withText: "얍")
    }
    
    override func setupLayout() {
        inputePlaceholderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(17 / 2)
        }
        
        inputTextBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
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
    }
}

extension MiddleView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        inputePlaceholderLabel.isHidden = true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        inputePlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}
