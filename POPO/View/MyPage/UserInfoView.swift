//
//  UserInfoView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class UserInfoView: BaseView {
    lazy var imageView = UIImageView()
    lazy var titleLabel = CustomLabel(text: "행운의 주인공", font: .body(ofSize: 15))
    lazy var nicknameTextField = UITextField()
    lazy var modifyButton = UIButton()
    
    var nickname = ""

    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubviews([imageView, titleLabel, nicknameTextField, modifyButton])
        
        backgroundColor = .white
        layer.cornerRadius = 16
        
        imageView.image = UIImage(named: "MyInfoImage")
        
        nicknameTextField.text = nickname
        nicknameTextField.isUserInteractionEnabled = false
        nicknameTextField.font = .bodyBold(ofSize: 22)
        
        modifyButton.setImage(UIImage(named: "ModifyUserInfo_Unselected"), for: .normal)
        modifyButton.setImage(UIImage(named: "ModifyUserInfo_Selected"), for: .selected)
        modifyButton.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
    }
    
    override func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints { make in            make.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalTo(titleLabel)
        }
        
        modifyButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
    }
    
    @objc private func modifyButtonTapped() {
        modifyButton.isSelected.toggle()
        
        if modifyButton.isSelected {
            nicknameTextField.isUserInteractionEnabled = true
            nicknameTextField.becomeFirstResponder()
        } else {
            nicknameTextField.isUserInteractionEnabled = false
            nicknameTextField.resignFirstResponder()
        }
    }
}
