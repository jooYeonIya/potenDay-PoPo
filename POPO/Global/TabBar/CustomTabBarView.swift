//
//  TabBarView.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit

protocol TabBarViewDelegate: AnyObject {
    func tabBarButtonTapped(option: TabBarOption)
}

class CustomTabBarView: BaseView {
    
    // 컴포넌트
    lazy var backgroundImageView = UIImageView()
    lazy var stackView = UIStackView()
    
    // 변수
    weak var delegate: TabBarViewDelegate?
    var selectedIndex: Int? {
        didSet { updateSelectedTabBarIcon() }
    }
    
    override func configure() {
        super.configure()
    }
    
    // UI Setup
    override func setupUI() {
        addSubviews([backgroundImageView, stackView])
        
        backgroundImageView.image = UIImage(named: "TabBarBackground")
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        createStackInnerView()
    }
    
    private func createStackInnerView() {
        let tabBarOption = TabBarOption.allCases
        
        tabBarOption.forEach { option in
            let imageButton = UIButton()
            imageButton.tag = option.rawValue
            imageButton.addTarget(self, action: #selector(tapBarButtonTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(imageButton)
        }
    }
    
    private func updateSelectedTabBarIcon() {
        for view in stackView.arrangedSubviews {
            if let imageButton = view as? UIButton {

                guard let option = TabBarOption(rawValue: view.tag) else { return }
                
                let number = view.tag == selectedIndex ? 1 : 6
                
                var configuration = UIButton.Configuration.plain()
                
                configuration.image = view.tag == selectedIndex ? option.selectedImage : option.image
                configuration.imagePlacement = .top
                configuration.imagePadding = 8
                
                let attributedString = NSAttributedString(string: option.title,
                                                          attributes: [.font: UIFont.body(ofSize: 11),
                                                                       .foregroundColor: UIColor.userGray(number)])
                
                configuration.attributedTitle = AttributedString(attributedString)
                                
                imageButton.configuration = configuration
                
                stackView.addArrangedSubview(imageButton)
            }
        }
    }
    
    @objc func tapBarButtonTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        guard let option = TabBarOption(rawValue: sender.tag) else { return }
        delegate?.tabBarButtonTapped(option: option)
    }

    // Layout Setup
    override func setupLayout() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
