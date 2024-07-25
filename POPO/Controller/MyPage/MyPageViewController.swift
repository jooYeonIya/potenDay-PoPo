//
//  MyPageViewController.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class MyPageViewController: BaseViewController {
    
    lazy var baseView = MyPageView()

    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.configure()
    }

}
