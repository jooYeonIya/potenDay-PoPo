//
//  NameViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa

class NameViewController: BaseViewController {
    
    // 컴포넌트
    let baseView = NameView()
        
    // 변수
    private let disposeBag = DisposeBag()
    var enterPressedSubject = PublishSubject<String?>()

    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
    
    override func setupEvent() {
        baseView.enterPressedSubject
            .bind { [weak self] text in
                self?.enterPressedSubject.onNext(text)
            }
            .disposed(by: disposeBag)
    }
}
