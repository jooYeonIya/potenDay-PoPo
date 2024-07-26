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
                self?.baseView.updateUIForSegmentChange(index)
            })
            .disposed(by: disposeBag)
        
        baseView.middleView.actionButton.rx
            .tap
            .bind { [weak self] in
                    
                self?.baseView.middleView.updateActionButtonLoading()
                self?.baseView.middleView.inputTextView.resignFirstResponder()
                
                let message = self?.baseView.middleView.inputTextView.text
                let character = SegmentedOption(rawValue: self?.baseView.segmentedView.segmentControl.selectedSegmentIndex ?? 1)?.apiName
//                let deviceId = UserDefaults.standard.string(forKey: "deviceId")
                let deviceId = "test Id"
                
                let messageRequest = MessageRequest(message: message ?? "",
                                                    deviceId: deviceId,
                                                    character: character ?? "POPO")
                
                ClovaAPIService.share.submitMessage(request: messageRequest) { result in
                    switch result {
                    case .success(let messageResponse):
                        self?.updateUI(response: messageResponse)
                    case .failure(let error):
                        print(error)
                    }
                }
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
    
    private func updateUI(response: MessageResponse) {
        baseView.middleView.characterTextView.text = response.data.clovaMood
        baseView.middleView.updateAcionButtonRepeat()
    }
}
