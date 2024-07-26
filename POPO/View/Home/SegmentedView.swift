//
//  SegmentedView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit

enum SegmentedOption: Int {
    case popo
    case viki
    
    var title: String {
        switch self {
        case .popo: return "포포"
        case .viki: return "비키"
        }
    }
    
    var imageName: String {
        switch self {
        case .popo: return "Charactor_Main"
        case .viki: return "Charactor_Viki"
        }
    }
    
    var apiName: String {
        switch self {
        case .popo: return "POPO"
        case .viki: return "VIKI"
        }
    }
}

class SegmentedView: BaseView {
    lazy var segmentControl: UISegmentedControl = {
        let items = [SegmentedOption.popo.title, SegmentedOption.viki.title]
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .userLightGreen
        segmentedControl.selectedSegmentTintColor = .white

        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.body(ofSize: 17),
            .foregroundColor: UIColor.userGray(4)
        ]
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.bodyBold(ofSize: 17),
            .foregroundColor: UIColor.userGreen
        ]
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        return segmentedControl
    }()
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubview(segmentControl)
    }
    
    override func setupLayout() {
        segmentControl.snp.makeConstraints { make in            
            make.center.width.height.equalToSuperview()
        }
    }
}
