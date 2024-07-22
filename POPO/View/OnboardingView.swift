//
//  OnboardingView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit
import SnapKit

class OnboardingView: BaseView {
    
    lazy var titleLabel = CustomLabel(text: "POPO", font: .boldSystemFont(ofSize: 16))
    
    lazy var nameTextField = UITextField()
    lazy var nameTitleLabel = CustomLabel(text: "행운이 찾아갈 너의 이름을 알려줘!", font: .systemFont(ofSize: 16))
    
    lazy var nextButton = UIButton()
    
    override func configure() {
        super.configure()
        backgroundColor = .white
    }
    
    override func setupUI() {
        addSubviews([titleLabel, nameTextField, nameTitleLabel, nextButton])
        
        titleLabel.textColor = .black
        
        nameTextField.configure()
        nameTitleLabel.textColor = .black
        
        nextButton.setImage(UIImage(systemName: "arrowshape.turn.up.right"), for: .normal)
        nextButton.addTarget(self, action: #selector(moveToNextView), for: .touchUpInside)
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(20)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(48)
        }
        
        nameTitleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nameTextField.snp.top).offset(-20)
            make.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(20)
            make.centerX.equalToSuperview()

            make.width.height.equalTo(40)
        }
    }
    
    @objc func moveToNextView() {
        print("moveToNextView")
    }
}
