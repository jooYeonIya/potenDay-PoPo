//
//  MyPageView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class MyPageView: BaseView {
    
    lazy var titleView = TitleView(title: "마이페이지")
    
    override func configure() {
        super.configure()
        backgroundColor = .white
    }
    
    override func setupUI() {
        addSubviews([titleView])
    }
    
    override func setupLayout() {
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}
