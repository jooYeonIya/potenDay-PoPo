//
//  MyPageView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class MyPageView: BaseView {
    
    lazy var titleView = TitleView(title: "마이페이지")
    lazy var userInfoView = UserInfoView()
    lazy var topBackgroundView = UIView()
    lazy var greenCircleView = UIView()
    lazy var blurView = UIVisualEffectView()
    lazy var QnATableView = UITableView()
    
    override func configure() {
        super.configure()
        backgroundColor = .userGray(9)
    }
    
    override func setupUI() {
        addSubviews([topBackgroundView, greenCircleView, blurView, titleView, userInfoView, QnATableView])
        
        topBackgroundView.backgroundColor = .userGray(9)
        
        greenCircleView.layer.cornerRadius = 411 / 2
        greenCircleView.backgroundColor = .userLightGreen

        blurView.effect = UIBlurEffect(style: .extraLight)
        
        QnATableView.register(QnATableViewCell.self, forCellReuseIdentifier: "QnATableViewCell")
        QnATableView.backgroundColor = .clear
        QnATableView.separatorStyle = .none
        QnATableView.showsVerticalScrollIndicator = false
        
        userInfoView.nickname = "나는야럭키걸"
        userInfoView.configure()
    }

    override func setupDelegate() {
        QnATableView.delegate = self
        QnATableView.dataSource = self
    }
    
    override func setupLayout() {
        topBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(userInfoView.snp.bottom).offset(12)
        }
        
        greenCircleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(411)
        }

        blurView.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(userInfoView.snp.bottom).offset(80)
            make.edges.equalToSuperview()
        }

        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(76)
        }
        
        QnATableView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MyPageView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QnATableViewCell", for: indexPath) as? QnATableViewCell else { return UITableViewCell() }
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         let footerView = UIView()
         footerView.backgroundColor = .clear
         return footerView
     }
     
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
         return 8
     }
}
