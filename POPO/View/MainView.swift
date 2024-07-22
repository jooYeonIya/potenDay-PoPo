//
//  MainView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

class MainView: BaseView {
    lazy var changerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        let titleLabel = CustomLabel(text: "긍정 변환기", font: .boldSystemFont(ofSize: 16))
        let subTitleLabel = CustomLabel(text: "무엇이든 긍정적으로 바꿔봐! \n 행운이 찾아올지도!", font: .systemFont(ofSize: 12))
        subTitleLabel.numberOfLines = 2
        subTitleLabel.textAlignment = .center
        
        view.addSubviews([titleLabel, subTitleLabel])
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(20)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        return view
    }()
    
    override func configure() {
        super.configure()
        backgroundColor = .white
    }
    
    override func setupUI() {
        addSubviews([changerView])
    }
    
    override func setupLayout() {
        changerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
    }
}
