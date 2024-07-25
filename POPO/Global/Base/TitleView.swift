//
//  TitleView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class TitleView: BaseView {

    lazy var titleLabel = UILabel()

    var title: String = ""
    
    init(title: String) {
        super.init(frame: .zero)
        self.title = title
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        titleLabel.text = title
        titleLabel.font = .bodyBold(ofSize: 22)
        titleLabel.textColor = .black
        
        addSubview(titleLabel)
    }
    
    override func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
