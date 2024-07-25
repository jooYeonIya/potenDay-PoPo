//
//  HomeViewController.swift
//  POPO
//
//  Created by 강주연 on 7/24/24.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {
    // MARK: - Component
    lazy var baseView = HomeView()
    
    private let disposeBag = DisposeBag()
    
    // MARK: - LifeCycle
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
    
    override func setupEvent() {
        baseView.segmentedView.segmentControl.rx
            .selectedSegmentIndex
            .bind(onNext: { [weak self] index in
                guard let option = SegmentedOption(rawValue: index) else { return }
                self?.baseView.middleView.characterImageView.image = UIImage(named: option.imageName)
                self?.baseView.middleView.characterTextView.text = option.title
            })
            .disposed(by: disposeBag)
    }
}
