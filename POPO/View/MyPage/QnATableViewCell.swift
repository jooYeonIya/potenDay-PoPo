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
    
    var content: Content?
    
    func configure(content: Content) {
        self.content = content
        setupUI()
        setupLayout()
    }
    
    private func setupUI() {
        contentView.addSubviews([QLabel, ALabel, answerLabel, dateLabel])
        
        contentView.backgroundColor = .white
        
        guard let content = content else { return }
        
        QLabel.text = content.userMood
        QLabel.font = .body(ofSize: 13)
        QLabel.textColor = .userGray(4)
        
        ALabel.text = content.clovaMood
        ALabel.font = .bodyBold(ofSize: 15)
        ALabel.numberOfLines = 0
        
        answerLabel.text = content.character == "POPO" ? "포포" : "비키"
        answerLabel.font = .body(ofSize: 11)
        answerLabel.textColor = .userGreen
        
        dateLabel.text = changeDate(dateString: content.date)
        dateLabel.font = .body(ofSize: 11)
        dateLabel.textColor = .userGray(6)
    }
    
    private func changeDate(dateString: String) -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = inputDateFormatter.date(from: dateString) {
            
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.locale = Locale(identifier: "ko_KR")
            outputDateFormatter.dateFormat = "yyyy년 M월 d일"
            
            // Date 객체를 원하는 형식의 문자열로 변환
            return outputDateFormatter.string(from: date)
        }
        
        return "yyyy년 M월 d일"
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
