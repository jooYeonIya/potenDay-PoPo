//
//  MakeCharmView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit
import SnapKit

class MakeCharmView: BaseView {

    lazy var titleLabel = CustomLabel(text: "행운부적", font: .boldSystemFont(ofSize: 16))
    lazy var subTitleLabel = CustomLabel(text: "이루어져라 얍 (클로버)", font: .boldSystemFont(ofSize: 16))

    lazy var charmImageView = UIImageView()
    
    lazy var saveButton = UIButton()
    lazy var shareButton = UIButton()
    
    override func configure() {
        super.configure()
        backgroundColor = .white
    }
    
    override func setupUI() {
        addSubviews([titleLabel, subTitleLabel, charmImageView, saveButton, shareButton])
        
        charmImageView.image = UIImage(named: "Charm")
        saveButton.setImage(UIImage(named: "Save"), for: .normal)
        shareButton.setImage(UIImage(named: "Share"), for: .normal)
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(40)
        }
        
        charmImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(charmImageView.snp.width).multipliedBy(1.2)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(charmImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview().offset(-20)
            make.width.height.equalTo(20)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview().offset(20)
            make.width.height.equalTo(20)
        }
    }
}
