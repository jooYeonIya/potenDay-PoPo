//
//  TotalCharmViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

class TotalCharmViewController: UIViewController {

    lazy var baseView = TotalCharmView()
        
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
}
