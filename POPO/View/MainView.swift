//
//  MainView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

class MainView: BaseView {
    
    // 같은 뷰 모양이니까 공통 뷰로 관리하기
    lazy var changerView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        
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
    
    lazy var charmView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 12
        view.layer.masksToBounds = true
        
        let titleLabel = CustomLabel(text: "부적 모아보기", font: .boldSystemFont(ofSize: 16))
        let subTitleLabel = CustomLabel(text: "지금까지 모은 부적을 확인해봐!", font: .systemFont(ofSize: 12))
        subTitleLabel.numberOfLines = 1
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
        addSubviews([changerView, charmView])
    }
    
    override func setupLayout() {
        changerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        charmView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(60)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
    }
}
