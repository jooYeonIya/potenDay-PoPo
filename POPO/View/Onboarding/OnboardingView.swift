//
//  OnboardingView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/24/24.
//

import UIKit
import SnapKit

class OnboardingView: BaseView {
    
    lazy var scrollView = UIScrollView()
    lazy var pageControl = UIPageControl()
    
    lazy var namePageView = UIView()
    lazy var agePageView = UIView()
        
    override func configure() {
        super.configure()
        backgroundColor = .userLightGreen
    }
    
    override func setupUI() {
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.allowsContinuousInteraction = false
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .userGreen
        pageControl.pageIndicatorTintColor = .userGray(4)
        
        let indicatorImage = UIImage(named: "Indicator")
        pageControl.setIndicatorImage(indicatorImage, forPage: 0)
        pageControl.setIndicatorImage(indicatorImage, forPage: 1)
        
        addSubviews([scrollView, pageControl])
        
        setupNamePageView()
        setupAgePageView()
        
        scrollView.addSubviews([namePageView, agePageView])
    }
    
    private func setupNamePageView() {
        let nameLabel = CustomLabel(text: "행운이 찾아갈 너의 이름을 알려줘!", font: .point(ofSize: 15))
        
        let nameTextField = UITextField()
        nameTextField.delegate = self
        nameTextField.background = UIImage(named: "BlurButton")
        nameTextField.textAlignment = .center
        nameTextField.tintColor = .userGreen
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.body(ofSize: 13),
            .foregroundColor: UIColor.userGray(4)
        ]
        nameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임, 애칭, 본명 뭐든 좋아",
                                                                 attributes: placeholderAttributes)
        
        
        namePageView.addSubviews([nameLabel, nameTextField])
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.centerX.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
    }
    
    private func setupAgePageView() {
        let ageLabel = CustomLabel(text: "나이대도 알려줄래?", font: .point(ofSize: 15))
        
        agePageView.addSubviews([ageLabel])
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
    }
    
    override func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.2)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom).offset(20)
        }
        
        namePageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        agePageView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
            make.leading.equalTo(namePageView.snp.trailing)
        }
    }
}

extension OnboardingView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
}

extension OnboardingView: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newLength = currentText.count + string.count - range.length
        return newLength <= 10
    }
}
