//
//  AgeViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/30/24.
//

import UIKit
import RxSwift
import RxCocoa

class AgeViewController: BaseViewController {

    let baseView = AgeView()
    
    private let disposeBag = DisposeBag()
    var selectedAgeSubject = PublishSubject<Int?>()
    
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
    
    override func setupEvent() {
        baseView.selectedAgeSubject
            .bind { [weak self] index in
                self?.selectedAgeSubject.onNext(index)
            }
            .disposed(by: disposeBag)
        
    }
}
