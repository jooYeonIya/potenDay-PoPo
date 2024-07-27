//
//  PopupView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/27/24.
//

import UIKit

class PopupView: BaseView {
    lazy var moveToHomeBUtton = UIButton()
    lazy var closeButton = UIButton()
    lazy var label = CustomLabel(text: "사진 앱에 부적이 저장됐어~", font: .bodyBold(ofSize: 17))
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        
        backgroundColor = .white
        layer.cornerRadius = 16
        layer.masksToBounds = true
        addSubviews([moveToHomeBUtton, closeButton, label])
        
        let option = BasicButtonOtpion(backgroundColor: .white,
                                       borderColor: .userGreen,
                                       fontColor: .userGreen,
                                       text: "처음으로",
                                       image: UIImage())
        moveToHomeBUtton.applyBasicButton(option)
        
        closeButton.setImage(UIImage(named: "CloseButton"), for: .normal)
    }
    
    override func setupLayout() {
        moveToHomeBUtton.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview().inset(16)
            make.width.height.equalTo(24)
        }
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-12)
        }
    }
}
