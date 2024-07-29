//
//  MyPageView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class MyPageView: BaseView {
    
    // 타이틀
    lazy var titleView = TitleView(title: "마이페이지")
    lazy var blurImageView = CustomImageView("BlurView")

    // 뒤 배경
    lazy var blurView = UIVisualEffectView()
    lazy var greenCircleView = UIView()

    // 유저 인포
    lazy var userInfoView = UserInfoView()

    // 메세지
    lazy var QnATableView = UITableView()
    
    // 노데이터 뷰
    lazy var noDataView = NoDataView(message: "아직 변환 기록이 없네! \n 포포나 비키에게 말을 걸어봐~")

    // 변수
    var contents: [Content] = [] {
        didSet {
            QnATableView.reloadData()
            noDataView.isHidden = !contents.isEmpty
            greenCircleView.isHidden = contents.isEmpty
        }
    }
    
    override func configure() {
        super.configure()
        backgroundColor = .userGray(9)
    }
    
    override func setupUI() {
        addSubviews([greenCircleView,
                     blurView,
                     titleView,
                     userInfoView,
                     QnATableView,
                     blurImageView,
                     noDataView])
        
        blurView.effect = UIBlurEffect(style: .extraLight)
        
        greenCircleView.createCircleView(.userLightGreen)
        
        userInfoView.configure()
        
        QnATableView.register(QnATableViewCell.self, forCellReuseIdentifier: "QnATableViewCell")
        QnATableView.backgroundColor = .clear
        QnATableView.separatorStyle = .none
        QnATableView.showsVerticalScrollIndicator = false
        QnATableView.alwaysBounceVertical = false
        QnATableView.reloadData()
        
        noDataView.configure()
        noDataView.isHidden = contents.isEmpty
    }

    override func setupDelegate() {
        QnATableView.delegate = self
        QnATableView.dataSource = self
    }
    
    override func setupLayout() {
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
            make.bottom.equalToSuperview()
        }

        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalTo(76)
        }
        
        noDataView.snp.makeConstraints { make in
            make.width.equalTo(290)
            make.height.equalTo(310)
            make.center.equalTo(QnATableView)
        }
        
        QnATableView.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension MyPageView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "QnATableViewCell", for: indexPath) as? QnATableViewCell else { return UITableViewCell() }
        cell.configure(content: contents[indexPath.section])
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

