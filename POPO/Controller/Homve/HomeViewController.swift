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
        
        baseView.middleView.actionButton.rx
            .tap
            .bind { [weak self] button in
                guard let button = self?.baseView.middleView.actionButton else { return }
                button.tag = button.tag == 0 ? 1 : 0
                let option = ActionButtonOtpion(rawValue: button.tag)
                self?.baseView.middleView.toggleActionButton(option!)
            }
            .disposed(by: disposeBag)
        
        baseView.moveTolackyCharmView.button.rx
            .tap
            .bind { [weak self] _ in
                let vc = MakeCharmViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
}
