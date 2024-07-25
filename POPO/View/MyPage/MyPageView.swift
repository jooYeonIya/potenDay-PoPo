//
//  MyPageView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class MyPageView: BaseView {
    
    lazy var titleView = TitleView(title: "마이페이지")
    lazy var myInfoView = MyInfoView()
    lazy var topBackgroundView = UIView()
    lazy var blurView = UIVisualEffectView()
    
    override func configure() {
        super.configure()
        backgroundColor = .userLightGreen
    }
    
    override func setupUI() {
        addSubviews([topBackgroundView, blurView, titleView, myInfoView])
        
        topBackgroundView.backgroundColor = .userGray(9)

        blurView.effect = UIBlurEffect(style: .extraLight)
        
        myInfoView.nickname = "나는야럭키걸"
        myInfoView.configure()
    }
    
    override func setupLayout() {
        topBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(myInfoView.snp.bottom).offset(12)
        }

        blurView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(myInfoView.snp.bottom).offset(80)
        }

        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        myInfoView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(76)
        }
    }
}
