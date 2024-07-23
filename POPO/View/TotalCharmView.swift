//
//  TotalCharmView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

class TotalCharmView: BaseView {
    
    private lazy var collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.minimumLineSpacing = 12
        flowlayout.minimumInteritemSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        collectionView.register(TotalCharmCollectionViewCell.self,
                                forCellWithReuseIdentifier: TotalCharmCollectionViewCell.identifier)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    override func configure() {
        addSubviews([collectionView])
        backgroundColor = .white
    }
    
    override func setupLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(8)
            make.bottom.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

extension TotalCharmView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = TotalCharmCollectionViewCell()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (frame.size.width
                     - (CGFloat(20) * 2)
                     - 12)
                    / 2
        
        return CGSize(width: width, height: width)
    }
}
