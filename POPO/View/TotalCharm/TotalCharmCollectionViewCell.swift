//
//  TotalCharmCollectionViewCell.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

protocol TotalCharmCollectionViewCellDelegate: AnyObject {
    func didCalculateHeight(_ height: CGFloat, for indexPath: IndexPath)  // 델리게이트 메서드
}

class TotalCharmCollectionViewCell: UICollectionViewCell {
    
    lazy var imageView = UIImageView()
    lazy var label = UILabel()
        
    weak var delegate: TotalCharmCollectionViewCellDelegate?
    
    private func calculateLabelHeight(for text: String) -> CGFloat {
        let width = contentView.frame.width
        let textAttributes = [NSAttributedString.Key.font: UIFont.body(ofSize: 13)]
        let textHeight = (text as NSString).boundingRect(with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: textAttributes, context: nil).height
        return textHeight
    }
    
    func configure(for indexPath: IndexPath) {
        contentView.addSubviews([imageView, label])
        
        imageView.image = UIImage(named: "DummyCharm")
        
        label.text = "다음 버스가 빨리 오길 빌어줄게 올지 않올진 모르겠지만 이렇게 생각하면 안되겠지 럭키비키"
        label.font = .body(ofSize: 13)
        label.textColor = .userGray(4)
        label.numberOfLines = 0
        
        let height = calculateLabelHeight(for: "다음 버스가 빨리 오길 빌어줄게 올지 않올진 모르겠지만 이렇게 생각하면 안되겠지 럭키비키")
        delegate?.didCalculateHeight(height + imageView.frame.height + 8, for: indexPath) 

        setupLayout()
    }

    private func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
//            make.height.equalTo(contentView.snp.height).multipliedBy(0.8)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.leading.trailing.equalTo(imageView)
//            make.bottom.equalToSuperview()
        }
    }
}
