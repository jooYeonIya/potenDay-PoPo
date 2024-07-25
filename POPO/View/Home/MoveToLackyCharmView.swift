//
//  MoveToLackyCharmView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/25/24.
//

import UIKit

class MoveToLackyCharmView: BaseView {
    
    let button = UIButton()
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        let option = BasicButtonOtpion(backgroundColor: .white,
                                       borderColor: .userGray(1), 
                                       fontColor: .userGray(1),
                                       text: "부적으로 행운을 빌어줄게!",
                                       image: UIImage(named: "DoneButton")!)
        button.applyBasicButton(option)
        
        addSubview(button)
    }
    
    override func setupLayout() {
        button.snp.makeConstraints { make in
            make.center.height.equalToSuperview()
            make.width.equalTo(200)
        }
    }
}
