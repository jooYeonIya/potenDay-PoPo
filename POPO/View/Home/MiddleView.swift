//
//  MiddleView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit
import SnapKit

class MiddleView: BaseView {
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
    }
    
    private func setupInputTextView() {
        inputTextBackgroundView.addSubview(inputTextView)
        inputTextBackgroundView.backgroundColor = .white
        inputTextBackgroundView.layer.cornerRadius = 20
        
        inputTextView.text = "포포한테 알려줘!"
        inputTextView.font = .body(ofSize: 17)
        inputTextView.textColor = .userGray(4)
        inputTextView.textAlignment = .center
    }
    
    override func setupLayout() {
        inputTextBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        inputTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(20)
            make.top.height.equalTo(100)
        }
    }
}
