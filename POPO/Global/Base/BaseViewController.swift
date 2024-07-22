//
//  BaseViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    lazy var topView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        setupLayout()
        setupDelegate()
        setupEvent()
    }
 
    func setupUI() {}
    func setupLayout() {}
    func setupDelegate() {}
    func setupEvent() {}
}
