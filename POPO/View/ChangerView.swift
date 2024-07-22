//
//  ChangerView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

class ChangerView: BaseView {
    
    lazy var inputTextBackgroundView = UIView()
    lazy var inputTextView = UITextView()
    lazy var bottomView = UIView()
    lazy var bottomImageButton = UIButton()
    lazy var bottomTextLable = CustomLabel(text: "변환하기", font: .boldSystemFont(ofSize: 16))
    
    override func configure() {
        super.configure()
        backgroundColor = .white
    }
    
    override func setupUI() {
        addSubviews([inputTextBackgroundView, bottomView])
        
        inputTextBackgroundView.addSubview(inputTextView)
        
        inputTextView.backgroundColor = .systemGray
        
        bottomView.backgroundColor = .green
        bottomView.addSubviews([bottomImageButton, bottomTextLable])
        
        bottomImageButton.setImage(UIImage(named: "logo"), for: .normal)
    }
    
    override func setupLayout() {
        inputTextBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        inputTextView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(80)
            make.height.equalTo(inputTextView.snp.width)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(inputTextBackgroundView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        bottomImageButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-12)
            make.width.height.equalTo(40)
        }
        
        bottomTextLable.snp.makeConstraints { make in
            make.top.equalTo(bottomImageButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
}
