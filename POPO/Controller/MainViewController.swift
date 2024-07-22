//
//  MainViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: BaseViewController {
    lazy var baseView = MainView()
    
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
        baseView.changerView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .bind { [weak self] _ in
                self?.changerViewTapped()
            }
            .disposed(by: disposeBag)
    }
    
    func changerViewTapped() {
        print("tapped")
    }
}
