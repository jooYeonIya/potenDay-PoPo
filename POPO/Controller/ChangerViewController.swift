//
//  ChangerViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit
import RxSwift
import RxCocoa

class ChangerViewController: BaseViewController {
    lazy var baseView = ChangerView()
    
    let disposeBag = DisposeBag()
        
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
    
    override func setupEvent() {
        let tapGesture = UITapGestureRecognizer()
        baseView.inputTextBackgroundView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .bind { [weak self] _ in
                self?.inputTextBackgroundViewTapped()
            }
            .disposed(by: disposeBag)
        
        baseView.bottomImageButton.rx.tap
            .bind { [weak self] _ in
                self?.bottomImageButtonTapped()
            }
            .disposed(by: disposeBag)

    }
    
    private func inputTextBackgroundViewTapped() {
        baseView.inputTextView.resignFirstResponder()
    }
    
    private func bottomImageButtonTapped() {
        baseView.changeViewLayout()
    }
}
