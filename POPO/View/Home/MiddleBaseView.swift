//
//  MiddleView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit
import SnapKit

class MiddleBaseView: BaseView {
    
    // Input 창
    lazy var inputTextViewBackgroundView = UIView()
    lazy var inputTextViewPlaceholderLabel = UILabel()
    lazy var inputTextView = UITextView()
    lazy var inputTextViewCountView = UIView()
    lazy var inputTextViewCountLabel = UILabel()
    lazy var inputTextViewCounterLabel = CustomLabel(text: "/50자", font: .body(ofSize: 11))

    // Output 창
    lazy var outPutSpeechBalloonImageView = CustomImageView("SpeechBalloon")
    lazy var outPutTextView = UITextView()
    lazy var outPutCharacterImageView = UIImageView()
    
    // 얍 버튼
    lazy var actionButton = UIButton()
    
    // 변수
    var option: SegmentedOption?
    
    init(option: SegmentedOption?) {
        self.option = option
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
    }
    
    // MARK: - Setup UI
    override func setupUI() {
        addSubviews([inputTextViewBackgroundView,
                     outPutSpeechBalloonImageView,
                     outPutCharacterImageView])
        
        setupInputTextView()
        setupOutputTextView()
    }
    
    // Input 창
    private func setupInputTextView() {
        inputTextViewBackgroundView.addSubviews([inputTextViewCountView,
                                                 inputTextView,
                                                 actionButton])
        
        inputTextViewBackgroundView.backgroundColor = .white
        inputTextViewBackgroundView.layer.cornerRadius = 20
        
        inputTextViewCountView.addSubviews([inputTextViewCountLabel, inputTextViewCounterLabel])
        inputTextViewCountLabel.text = "0"
        inputTextViewCountLabel.font = .body(ofSize: 11)
        inputTextViewCountLabel.textColor = .userGreen
        inputTextViewCounterLabel.textColor = .userGray(6)
        
        inputTextViewPlaceholderLabel.text = "\(option?.title ?? "포포")에게 알려줘!"
        inputTextViewPlaceholderLabel.textColor = .userGray(4)
        inputTextViewPlaceholderLabel.font = .body(ofSize: 17)
        
        inputTextView.text = .none
        inputTextView.addSubview(inputTextViewPlaceholderLabel)
        inputTextView.font = .body(ofSize: 17)
        inputTextView.textColor = .userGray(1)
        inputTextView.textAlignment = .center
        inputTextView.delegate = self
        
        toggleActionButton(.deselected)
    }

    // Output 창
    private func setupOutputTextView() {
        guard let option = option else { return }
        
        outPutSpeechBalloonImageView.addSubviews([outPutTextView])
        
        outPutCharacterImageView.image = UIImage(named: option.imageName)
        
        outPutTextView.text = SegmentedOption(rawValue: option.rawValue)?.description
        outPutTextView.font = .point(ofSize: 15)
        outPutTextView.textAlignment = .center
    }
    
    // MARK: - 얍 버튼 토글
    func toggleActionButton(_ option: ActionButtonOtpion) {
        switch option {
        case .deselected: updateActionButtonDeselected("얍", imageName: "Clover_Deselected")
        case .selected: updateActionButtonSelected("얍")
        case .loading: updateActionButtonDeselected("로딩중..", imageName: "Loading")
        case .retry: updateActionButtonSelected("다시하기")
        }
        
        actionButton.tag = option.rawValue
    }
    
    func updateActionButtonDeselected(_ text: String, imageName: String) {
        let buttonOption = BasicButtonOtpion(backgroundColor: .userGray(8),
                                             borderColor: .userGray(6),
                                             fontColor: .userGray(4),
                                             text: text,
                                             image: UIImage(named: imageName)!)
        actionButton.applyBasicButton(buttonOption)
        actionButton.isEnabled = false
    }
    
    func updateActionButtonSelected(_ text: String) {
        let buttonOption = BasicButtonOtpion(backgroundColor: .white,
                                             borderColor: .userGreen,
                                       fontColor: .userGray(1),
                                       text: text,
                                       image: UIImage(named: "Clover_Selected")!)
        actionButton.applyBasicButton(buttonOption)
        actionButton.isEnabled = true
    }
    
    func actionButtonTapped(_ buttonOtion: ActionButtonOtpion) {
        if buttonOtion == .retry {
            inputTextView.text = .none
            inputTextViewPlaceholderLabel.isHidden = false
            outPutTextView.text = option?.description
            toggleActionButton(.deselected)
        } else {
            updateActionButtonDeselected("로딩중..", imageName: "Loading")
            inputTextView.resignFirstResponder()
        }
    }
    
    // MARK: - Setup Layout
    override func setupLayout() {
        // Input 창 (+ acitonButton)
        inputTextViewBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(38)
            make.height.equalTo(200)
        }
        
        inputTextViewCountView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(37)
            make.height.equalTo(13)
        }
        
        inputTextViewCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(inputTextViewCounterLabel.snp.leading).offset(-4)
        }
        
        inputTextViewCounterLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        inputTextViewPlaceholderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(inputTextView.snp.top)
        }
    
        inputTextView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(100)
        }
        
        actionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.width.equalTo(120)
        }

        // Output 창
        outPutSpeechBalloonImageView.snp.makeConstraints { make in
            make.top.equalTo(inputTextViewBackgroundView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(inputTextViewBackgroundView)
            make.height.equalTo(174)
        }
        
        outPutTextView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-24)
            make.width.equalTo(240)
        }
        
        outPutCharacterImageView.snp.makeConstraints{ make in
            make.top.equalTo(outPutSpeechBalloonImageView.snp.bottom).offset(-16)
            make.trailing.equalTo(inputTextViewBackgroundView.snp.trailing)
            make.width.height.equalTo(100)
        }
    }
    
    // MARK: - Update
    func updateUIForSegmentedControl(_ option: SegmentedOption) {
        inputTextViewPlaceholderLabel.text = "\(option.title)에게 알려줘!"
        outPutTextView.text = option.description
        outPutCharacterImageView.image = UIImage(named: option.imageName)
    }
    
    func updateUIForYaapButtonTppaed(_ answer: String) {
        outPutTextView.text = answer
        toggleActionButton(.retry)
    }
}

// 텍스트뷰 델리게이트
extension MiddleBaseView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        inputTextViewPlaceholderLabel.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        inputTextViewPlaceholderLabel.isHidden = !(textView.text.count <= 0)
    }
        
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        guard let textViewText = textView.text as NSString? else { return true }
        let newText = textViewText.replacingCharacters(in: range, with: text)
            
        inputTextViewCountLabel.text = String(newText.count)

        if newText.count > 50 || newText.isEmpty {
            toggleActionButton(.deselected)
        } else {
            toggleActionButton(.selected)
        }
        
        return newText.count <= 50
    }
}
