//
//  TotalCharmView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit
import SnapKit

class TotalCharmView: BaseView {
    
    lazy var titleView = TitleView(title: "행운 부적 모음집")
    lazy var topBackgroundView = UIView()
    lazy var blurView = UIVisualEffectView()
    lazy var tabBarView = TabBarView()
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(TotalCharmCollectionViewCell.self, forCellWithReuseIdentifier: "TotalCharmCollectionViewCell")

        return collectionView
    }()
    
    private var cellHeights: [IndexPath: CGFloat] = [:]
    
    override func configure() {
        super.configure()
        
        backgroundColor = .userGray(9)
    }
    
    override func setupUI() {
        addSubviews([topBackgroundView, blurView, titleView, collectionView, tabBarView])
        
        topBackgroundView.backgroundColor = .userGray(9)

        blurView.effect = UIBlurEffect(style: .extraLight)
        
        tabBarView.configure()
    }
    
    override func setupLayout() {
        topBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(titleView.snp.bottom).offset(12)
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        tabBarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(80)
        }
    }
}

extension TotalCharmView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TotalCharmCollectionViewCell", for: indexPath) as? TotalCharmCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self

        cell.configure(for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 16
        let height = cellHeights[indexPath] ?? 100
        return CGSize(width: width, height: height)
    }
}

extension TotalCharmView: TotalCharmCollectionViewCellDelegate {
    func didCalculateHeight(_ height: CGFloat, for indexPath: IndexPath) {
        cellHeights[indexPath] = height
        collectionView.reloadData()
    }
}

