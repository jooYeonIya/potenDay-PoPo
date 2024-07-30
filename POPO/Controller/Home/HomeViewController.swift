//
//  HomeViewController.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    // 컴포넌트
    lazy var baseView = HomeBaseView(option: .popo)
    
    // 변수
    private let disposeBag = DisposeBag()
    
    var answer = ""
    
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        baseView.configure()
    
        toggleToolTip()
    }

    // 툴팁 관련
    func toggleToolTip() {
        if UserDefaults.standard.bool(forKey: "isHomeToolTipShow") {
            self.baseView.toolTipView.isHidden = true
            self.baseView.toolTipViewTextLabel.isHidden = true
        } else {
            baseView.toolTipView.isHidden = false
            baseView.toolTipViewTextLabel.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.baseView.toolTipView.isHidden = true
                self.baseView.toolTipViewTextLabel.isHidden = true
            }
            
            UserDefaults.standard.setValue(true, forKey: "isHomeToolTipShow")
        }
    }
 }
