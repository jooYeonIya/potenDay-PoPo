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
 
    func setupDelegate() {}
    func setupEvent() {}
}

extension BaseViewController {
    func showAlertOneButton(title: String?,
                            message: String?,
                            actionTitle: String = "확인",
                            completion: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionTitle, style: .default) { _ in
            completion?()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
}
