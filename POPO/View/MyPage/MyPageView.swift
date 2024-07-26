//
//  MyPageView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

protocol MyPageViewDelegate: AnyObject {
    func moveToView(index: Int)
}

class MyPageView: BaseView {
    
    lazy var titleView = TitleView(title: "마이페이지")
    lazy var userInfoView = UserInfoView()
    lazy var topBackgroundView = UIView()
    lazy var greenCircleView = UIView()
    lazy var blurView = UIVisualEffectView()
    lazy var QnATableView = UITableView()
    lazy var blurImageView = UIImageView()
    lazy var tabBarView = TabBarView(selectedIndex: TabBarOption.myPage.rawValue)

    weak var delegate: MyPageViewDelegate?
    
    override func configure() {
        super.configure()
        backgroundColor = .userGray(9)
    }
    
    override func setupUI() {
        addSubviews([topBackgroundView, greenCircleView, blurView, QnATableView, titleView, userInfoView, tabBarView, blurImageView])
        
        topBackgroundView.backgroundColor = .userGray(9)
        
        blurImageView.image = UIImage(named: "BlurView")
        
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
        
        tabBarView.delegate = self
    }
    
    override func setupLayout() {
        topBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalTo(userInfoView.snp.bottom).offset(12)
        }
        
        greenCircleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(411)
            make.bottom.equalTo(tabBarView.snp.top).offset(-16)
        }

        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        blurImageView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
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
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(tabBarView.snp.top)
        }
        
        tabBarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-20)
            make.height.equalTo(80)
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

extension MyPageView: TabBarViewDelegate {
    func tabBarButtonTapped(index: Int) {
        delegate?.moveToView(index: index)
    }
}
