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
    lazy var nameTextField = UITextField()

    lazy var agePageView = UIView()
    
    lazy var rightButton = UIButton()
    
    lazy var errorLabel = CustomLabel(text: "닉네임은 10글자 내로 부탁할게~", font: .body(ofSize: 11))
    
    lazy var doneButton = UIButton()
    
    var selecetedUserAge = 99
    
    var isNotAgeView: Bool = true {
        willSet {
            doneButton.isHidden = newValue
        }
    }
    
    override func configure() {
        super.configure()
        backgroundColor = .userLightGreen
    }
    
    override func setupUI() {
        scrollView.isScrollEnabled = false
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
        
        errorLabel.isHidden = true
        errorLabel.textColor = .systemRed
        
        doneButton.applyBlurButton(withImage: UIImage(named: "Clover_Selected")!, withText: "준비 끝!", fontSize: 15)
        doneButton.isHidden = isNotAgeView
        
        addSubviews([scrollView, pageControl, errorLabel, doneButton])
        
        setupNamePageView()
        setupAgePageView()
        
        scrollView.addSubviews([namePageView, agePageView])
    }
    
    private func setupNamePageView() {
        let nameLabel = CustomLabel(text: "행운이 찾아갈 너의 이름을 알려줘!", font: .point(ofSize: 15))
        
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
        
        rightButton.setImage(UIImage(named: "CancelButton"), for: .normal)
        rightButton.isHidden = true
        
        nameTextField.addSubview(rightButton)
        
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
        
        namePageView.addSubviews([nameLabel, nameTextField])
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.centerX.leading.trailing.equalToSuperview()
            make.height.equalTo(76)
        }
    }
    
    private func setupAgePageView() {
        let ageLabel = CustomLabel(text: "나이대도 알려줄래?", font: .point(ofSize: 15))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 68, height: 40)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AgePageCollectionViewCell.self,
                                forCellWithReuseIdentifier: "AgePageCollectionViewCell")
        
        agePageView.addSubviews([ageLabel, collectionView])
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.centerX.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(ageLabel.snp.bottom).offset(12)
            make.centerX.leading.trailing.equalToSuperview()
            make.height.equalTo(76)
        }
    }
    
    override func setupLayout() {
        scrollView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.8)
            
            let deviceHasHomeButton = UIDevice.current.hasHomeButton
            let number = deviceHasHomeButton ? 0.25 : 0.2
            make.height.equalToSuperview().multipliedBy(number)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(scrollView.snp.bottom).offset(20)
        }
        
        errorLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(pageControl.snp.top)
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
        
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
    
    @objc private func rightButtonTapped() {
        let pageWidth = scrollView.frame.width
        let offset = CGPoint(x: pageWidth * 1, y: 0)
        scrollView.setContentOffset(offset, animated: true)
        scrollView.isScrollEnabled = true
    }
}

extension OnboardingView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        isNotAgeView.toggle()
    }
}

extension OnboardingView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
        rightButton.isHidden = !textField.isEditing
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        if let text = textField.text,
           !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if text.count < 11 {
                rightButton.setImage(UIImage(named: "DoneButton"), for: .normal)
                rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
                rightButton.isEnabled = true
                errorLabel.isHidden = true
            } else {
                rightButton.setImage(UIImage(named: "CancelButton"), for: .normal)
                rightButton.isEnabled = false
                errorLabel.isHidden = false
            }
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        let newLength = currentText.count + string.count - range.length
        return newLength <= 11
    }
}

extension OnboardingView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Ages.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgePageCollectionViewCell", for: indexPath) as! AgePageCollectionViewCell
        cell.configure(text: Ages.from(number: indexPath.row)?.description ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AgePageCollectionViewCell
        cell.configure(text: Ages.from(number: indexPath.row)?.description ?? "")
        selecetedUserAge = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AgePageCollectionViewCell
        cell.configure(text: Ages.from(number: indexPath.row)?.description ?? "")
    }
}
