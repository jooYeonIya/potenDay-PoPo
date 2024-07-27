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
    
    // 타이틀
    lazy var topBackgroundView = UIView()
    lazy var titleView = TitleView(title: "마이페이지")
    lazy var blurImageView = UIImageView()

    // 뒤 배경
    lazy var blurView = UIVisualEffectView()
    lazy var greenCircleView = UIView()

    // 유저 인포
    lazy var userInfoView = UserInfoView()

    // 메세지
    lazy var QnATableView = UITableView()
    
    // 탭바
    lazy var tabBarView = TabBarView(selectedIndex: TabBarOption.myPage.rawValue)

    // 변수
    weak var delegate: MyPageViewDelegate?
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubviews([greenCircleView,
                     topBackgroundView,
                     titleView,
                     blurImageView,
                     blurView,
                     userInfoView,
                     QnATableView,
                     tabBarView])
        
        backgroundColor = .userGray(9)

        topBackgroundView.backgroundColor = .userGray(9)
        
        blurImageView.image = UIImage(named: "BlurView")
        
        blurView.effect = UIBlurEffect(style: .extraLight)
        
        greenCircleView.layer.cornerRadius = 411 / 2
        greenCircleView.backgroundColor = .userLightGreen
        
        userInfoView.configure()
        
        QnATableView.register(QnATableViewCell.self, forCellReuseIdentifier: "QnATableViewCell")
        QnATableView.backgroundColor = .clear
        QnATableView.separatorStyle = .none
        QnATableView.showsVerticalScrollIndicator = false
        QnATableView.alwaysBounceVertical = false
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
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        blurImageView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        greenCircleView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.height.equalTo(411)
            make.bottom.equalTo(tabBarView.snp.top).offset(-16)
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
