//
//  UserInfoView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

protocol UserInfoViewDelegate: AnyObject {
    func modifyName()
}

class UserInfoView: BaseView {
    // 컴포넌트
    lazy var charactorImageView = CustomImageView("MyInfoImage")
    lazy var titleLabel = CustomLabel(text: "행운의 주인공", font: .body(ofSize: 15))
    lazy var nameTextField = UITextField()
    lazy var nameModifyButton = UIButton()
    
    // 변수
    weak var delegate: UserInfoViewDelegate?

    override func configure() {
        super.configure()
        backgroundColor = .white
        layer.cornerRadius = 16
    }
    
    override func setupUI() {
        addSubviews([charactorImageView, titleLabel, nameTextField, nameModifyButton])
        
        nameTextField.isUserInteractionEnabled = false
        nameTextField.font = .bodyBold(ofSize: 22)
        
        nameModifyButton.setImage(UIImage(named: "Modify_Deselected"), for: .normal)
        nameModifyButton.setImage(UIImage(named: "Modify_Selected"), for: .selected)
        nameModifyButton.addTarget(self, action: #selector(modifyButtonTapped), for: .touchUpInside)
    }
    
    override func setupLayout() {
        charactorImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(8)
            make.width.height.equalTo(56)
        }
        
        titleLabel.snp.makeConstraints { make in            make.leading.equalTo(charactorImageView.snp.trailing).offset(8)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalTo(titleLabel)
        }
        
        nameModifyButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(63)
            make.height.equalTo(32)
        }
    }
    
    // 이름 수정
    @objc private func modifyButtonTapped() {
        nameModifyButton.isSelected.toggle()
        
        if nameModifyButton.isSelected {
            nameTextField.isUserInteractionEnabled = true
            nameTextField.becomeFirstResponder()
        } else {
            nameTextField.isUserInteractionEnabled = false
            nameTextField.resignFirstResponder()
        }
        
        delegate?.modifyName()
    }
}
