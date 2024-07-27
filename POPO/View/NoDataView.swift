//
//  NoDataView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/28/24.
//

import UIKit

class NoDataView: BaseView {
    lazy var clover = UIImageView(image: UIImage(named: "Clover_Selected"))
    lazy var imageView = UIImageView(image: UIImage(named: "NoData"))
    lazy var mainCharctor = UIImageView(image: UIImage(named: "Charactor_Main"))
    lazy var vikiCharctor = UIImageView(image: UIImage(named: "Charactor_Viki"))
    lazy var label = UILabel()
    
    var message = ""
    
    init(message: String) {
        self.message = message
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        addSubviews([imageView, mainCharctor, vikiCharctor, label, clover])
        
        backgroundColor = .userGray(9)
        
        label.text = message
        label.font = .bodyBold(ofSize: 17)
        label.textAlignment = .center
        label.numberOfLines = 0
    }
    
    override func setupLayout() {
        clover.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(33)
            make.width.height.equalTo(24)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(clover.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
        }
        
        mainCharctor.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalTo(vikiCharctor.snp.leading).offset(28)
            make.width.height.equalTo(100)
        }
        
        vikiCharctor.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}
