//
//  MakeCharmView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/25/24.
//

import UIKit

class MakeCharmView: BaseView {

    lazy var titleView = TitleView(title: "행운부적")
    let cardImageView = UIImageView(image: UIImage(named: "DummyCharm"))
    let bottomLabel = UILabel()
    let closeButton = UIButton(type: .system)
    let saveButton = UIButton(type: .system)
    let shareButton = UIButton()
    
    
    override func configure() {
        super.configure()
        backgroundColor = .userLightGreen
    }
    
    override func setupUI() {
        addSubviews([titleView, cardImageView, bottomLabel, saveButton, closeButton, shareButton])

        cardImageView.contentMode = .scaleAspectFit
        cardImageView.layer.shadowColor = UIColor.userGray(1).cgColor
        cardImageView.layer.shadowOpacity = 0.4
        cardImageView.layer.shadowRadius = 10
        cardImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        bottomLabel.text = "다음 버스가 빨리 오기를 빌어줄게!🍀"
        bottomLabel.font = .body(ofSize: 15)
        bottomLabel.textColor = .userGray(1)
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "Clover_Selected")
        configuration.imagePadding = 4
        configuration.background.image = UIImage(named: "SaveButton")
        
        let attributedString = NSAttributedString(string: "저장하기", attributes: [.font: UIFont.body(ofSize: 15), .foregroundColor: UIColor.userGray(1)])
        configuration.attributedTitle = AttributedString(attributedString)
        
        saveButton.configuration = configuration
        
        var closeConfiguration = UIButton.Configuration.plain()
        closeConfiguration.image = UIImage(named: "Close")
        closeConfiguration.imagePadding = 4
        
        let closeAttributedString = NSAttributedString(string: "닫기", attributes: [.font: UIFont.body(ofSize: 15), .foregroundColor: UIColor.userGray(4)])
        closeConfiguration.attributedTitle = AttributedString(closeAttributedString)
        
        closeButton.configuration = closeConfiguration
        
        shareButton.setBackgroundImage(UIImage(named: "ShareButton"), for: .normal)
    }
    
    override func setupLayout() {

        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }

        cardImageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(458)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(cardImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(bottomLabel.snp.bottom).offset(24)
            make.height.equalTo(80)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.top)
            make.trailing.equalTo(saveButton.snp.leading).offset(-8)
            make.leading.equalToSuperview().offset(32)
            make.width.height.equalTo(80)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
    }
}
