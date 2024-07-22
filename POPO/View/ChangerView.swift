//
//  ChangerView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit
import SnapKit

class ChangerView: BaseView {
    
    lazy var inputTextBackgroundView = UIView()
    lazy var inputTextView = UITextView()
    lazy var bottomView = UIView()
    lazy var bottomImageButton = UIButton()
    lazy var bottomTextLable = CustomLabel(text: "변환하기", font: .boldSystemFont(ofSize: 16))
    
    private var inputTextBackgroundViewHeightConstraint: Constraint?
    
    override func configure() {
        super.configure()
        backgroundColor = .white
    }
    
    override func setupUI() {
        addSubviews([inputTextBackgroundView, bottomView])
        
        inputTextBackgroundView.addSubview(inputTextView)
        
        inputTextView.backgroundColor = .systemGray
        
        bottomView.backgroundColor = .green
        bottomView.addSubviews([bottomImageButton, bottomTextLable])
        
        bottomImageButton.setImage(UIImage(named: "logo"), for: .normal)
    }
    
    override func setupLayout() {
        inputTextBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()

            let height = UIScreen.main.bounds.height * 0.6
            make.height.equalTo(height)
        }
        
        inputTextView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(80)
            make.height.equalTo(inputTextView.snp.width)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(inputTextBackgroundView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        bottomImageButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.width.height.equalTo(40)
        }
        
        bottomTextLable.snp.makeConstraints { make in
            make.top.equalTo(bottomImageButton.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
        }
    }
    
    func changeViewLayout() {
        inputTextBackgroundView.snp.updateConstraints { make in
            let height = inputTextView.snp.width
            //이거 수치를 조정해야 할 필요 있을 것 같음
            make.height.equalTo(200)
        }
        
        bottomTextLable.text = "행운부적 만들기"
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}
