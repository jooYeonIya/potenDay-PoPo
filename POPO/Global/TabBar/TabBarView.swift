//
//  TabBarView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit

enum TabBarOption: Int, CaseIterable {
    case totalCharm
    case home
    case myPage
    
    var title: String {
        switch self {
        case .totalCharm: return "부적 모아보기"
        case .home: return "홈"
        case .myPage: return "마이페이지"
        }
    }
    
    var image: UIImage {
        switch self {
        case .totalCharm: return UIImage(named: "Charm_Deselected")!
        case .home: return UIImage(named: "Home_Deselected")!
        case .myPage: return UIImage(named: "MyPage_Deselected")!
        }
    }
    
    var selectedImage: UIImage {
        switch self {
        case .totalCharm: return UIImage(named: "Charm")!
        case .home: return UIImage(named: "Home")!
        case .myPage: return UIImage(named: "MyPage")!
        }
    }
}

class TabBarView: BaseView {
    
    lazy var backgroundImageView = UIImageView()
    lazy var stackView = UIStackView()
    
    var selectedIndex: Int = 1 {
        didSet {
            updateSelectedTab()
        }
    }
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubviews([backgroundImageView, stackView])
        
        backgroundImageView.image = UIImage(named: "TabBarBackground")
        
        createStackInnerView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
    }
    
    private func createStackInnerView() {
        let tabBarOption = TabBarOption.allCases
        
        tabBarOption.forEach { option in
            let imageButton = UIButton()
            imageButton.tag = option.rawValue
            stackView.addArrangedSubview(imageButton)
        }
        
        selectedIndex = 1
    }
    
    private func updateSelectedTab() {
        for view in stackView.arrangedSubviews {
            if let imageButton = view as? UIButton {
                
                guard let option = TabBarOption(rawValue: view.tag) else { return }
                
                var configuration = UIButton.Configuration.plain()
                
                let number = view.tag == selectedIndex ? 1 : 6
                let attributedString = NSAttributedString(string: option.title, attributes: [.font: UIFont.body(ofSize: 11), .foregroundColor: UIColor.userGray(number)])
                
                configuration.attributedTitle = AttributedString(attributedString)
                configuration.image = view.tag == selectedIndex ? option.selectedImage : option.image
                configuration.imagePlacement = .top
                configuration.imagePadding = 8
                                
                imageButton.configuration = configuration
                
                imageButton.addTarget(self, action: #selector(tapBarButtonTapped(_:)), for: .touchUpInside)
                
                stackView.addArrangedSubview(imageButton)
                
                imageButton.snp.makeConstraints { make in
                    make.centerY.equalToSuperview()
                    
                    let width = frame.width / 3
                    make.width.equalTo(width)
                }
            }
        }
    }
    
    override func setupLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    @objc func tapBarButtonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
    }
}
