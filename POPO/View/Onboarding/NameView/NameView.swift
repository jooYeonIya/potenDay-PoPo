//
//  NameView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa

class NameView: BaseView {
    
    // 컴포넌트
    lazy var nameLabel = CustomLabel(text: "행운이 찾아갈 너의 이름을 알려줘!", font: .point(ofSize: 15))
    lazy var errorLabel = CustomLabel(text: "닉네임은 10글자 내로 부탁할게~", font: .body(ofSize: 11), fontColor: .systemRed)
    lazy var nameTextField = UITextField()
    lazy var moveToAgeViewButton = UIButton()
    
    // 변수
    var enterPressedSubject = PublishSubject<String?>()
    
    override func configure() {
        super.configure()
    }
    
    // Setup UI
    override func setupUI() {
        addSubviews([nameLabel, errorLabel, nameTextField])
        
        nameTextField.addSubview(moveToAgeViewButton)
        nameTextField.background = UIImage(named: "BlurButton")
        nameTextField.textAlignment = .center
        nameTextField.tintColor = .userGreen
        
        setupPlaceholder()
       
        moveToAgeViewButton.setImage(UIImage(named: "CancelButton"), for: .normal)
        moveToAgeViewButton.setImage(UIImage(named: "DoneButton"), for: .selected)
        moveToAgeViewButton.isHidden = true

        errorLabel.isHidden = true
    }
    
    private func setupPlaceholder() {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [ .font: UIFont.body(ofSize: 13),
                                                                     .foregroundColor: UIColor.userGray(4)]

        nameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임, 애칭, 본명 뭐든 좋아",
                                                                 attributes: placeholderAttributes)
    }
    
    // Setup Delegate
    override func setupDelegate() {
        nameTextField.delegate = self
    }
    
    // Setup Layout
    override func setupLayout() {
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(176)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(32)
            make.height.equalTo(76)
        }
        
        moveToAgeViewButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
        }
                
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameTextField.snp.bottom).offset(16)
        }
    }
}

extension NameView: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = .none
        moveToAgeViewButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        setupPlaceholder()
        moveToAgeViewButton.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text,
           !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            enterPressedSubject.onNext(text)
        }
        
        return true
    }
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else { return true }
        let newText = text.replacingCharacters(in: range, with: string)
        moveToAgeViewButton.isSelected = !newText.isEmpty
        return newText.count <= 11
    }
}
