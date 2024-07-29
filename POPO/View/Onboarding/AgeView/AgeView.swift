//
//  AgeView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa

class AgeView: BaseView {
    
    // 컴포넌트
    lazy var doneButton = UIButton()
    lazy var ageLabel = CustomLabel(text: "나이대도 알려줄래?", font: .point(ofSize: 15))
    lazy var ageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 8
        layout.itemSize = CGSize(width: 68, height: 40)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AgeViewCollectionViewCell.self,
                                forCellWithReuseIdentifier: "AgeViewCollectionViewCell")
        
        return collectionView
    }()
    
    // 변수
    var selectedAgeSubject = PublishSubject<Int?>()

    override func configure() {
        super.configure()
    }
    
    // Setup UI
    override func setupUI() {
        addSubviews([doneButton, ageLabel, ageCollectionView])
            
        doneButton.isEnabled = false
        doneButton.applyBlurButton(withImage: UIImage(named: "Clover_Deselected")!,
                                   withText: "기다리는 중..",
                                   fontSize: 15,
                                   fontColor: .userGray(4))
    }
    
    // Setup Delegate
    override func setupDelegate() {
        ageCollectionView.dataSource = self
        ageCollectionView.delegate = self
    }
    
    // Setup Layout
    override func setupLayout() {
        ageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(176)
        }
        
        ageCollectionView.snp.makeConstraints { make in
            make.centerX.leading.trailing.equalToSuperview()
            make.top.equalTo(ageLabel.snp.bottom).offset(8)
            make.height.equalTo(40)
        }
        
        doneButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
        }
    }
}


extension AgeView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Ages.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgeViewCollectionViewCell", for: indexPath) as! AgeViewCollectionViewCell
        cell.configure(text: Ages.from(number: indexPath.row)?.description ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AgeViewCollectionViewCell
        cell.configure(text: Ages.from(number: indexPath.row)?.description ?? "")
        
        selectedAgeSubject.onNext(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AgeViewCollectionViewCell
        cell.configure(text: Ages.from(number: indexPath.row)?.description ?? "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}
