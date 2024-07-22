//
//  BaseViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDelegate()
        setupEvent()
    }
 
    private func setupDelegate() {}
    private func setupEvent() {}
}
