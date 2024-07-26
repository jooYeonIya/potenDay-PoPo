//
//  QnATableViewCell.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class QnATableViewCell: UITableViewCell {
    lazy var QLabel = UILabel()
    lazy var ALabel = UILabel()
    lazy var answerLabel = UILabel()
    lazy var dateLabel = UILabel()
    
    func configure() {
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        contentView.addSubviews([QLabel, ALabel, answerLabel, dateLabel])
        
        contentView.backgroundColor = .white
        
        QLabel.text = "버스를 놓쳤어"
        QLabel.font = .body(ofSize: 13)
        QLabel.textColor = .userGray(4)
        
        ALabel.text = "다음 버스를 기다리는 동안 그냥 땀만 흐르지 않을까 이놈아 라고 하면 안되겠지 나는 럭키비키니까!"
        ALabel.font = .bodyBold(ofSize: 15)
        ALabel.numberOfLines = 0
        
        answerLabel.text = "포포"
        answerLabel.font = .body(ofSize: 11)
        answerLabel.textColor = .userGreen
        
        dateLabel.text = "2024년 7월 21일"
        dateLabel.font = .body(ofSize: 11)
        dateLabel.textColor = .userGray(6)
    }
    
    private func setupLayout() {
        QLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(38)
        }
        
        ALabel.snp.makeConstraints { make in
            make.top.equalTo(QLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(QLabel)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.top.equalTo(ALabel.snp.bottom).offset(8)
            make.leading.equalTo(QLabel.snp.leading)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(ALabel.snp.bottom).offset(8)
            make.leading.equalTo(answerLabel.snp.trailing).offset(4)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
}
