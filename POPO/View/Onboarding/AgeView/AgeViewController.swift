//
//  AgeViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/30/24.
//

import UIKit

class AgeViewController: UIViewController {

    let baseView = AgeView()
    
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
}
