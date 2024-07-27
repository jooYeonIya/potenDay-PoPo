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
    lazy var baseView = HomeBaseView(option: .popo)
    private let disposeBag = DisposeBag()
    
    var answer = ""
    
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
        baseView.delegate = self
        baseView.middleView.delegate = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        if UserDefaults.standard.bool(forKey: "isOnboardingCompleted") {
            baseView.toolTipView.isHidden = true
            baseView.toolTipViewTextLabel.isHidden = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.baseView.toolTipView.isHidden = true
                self.baseView.toolTipViewTextLabel.isHidden = true
            }
        }
    }

    override func setupEvent() {
        // 세그먼티트 컨트롤러 탭했을 때
        baseView.segmentedView.segmentControl.rx
            .selectedSegmentIndex
            .bind(onNext: { [weak self] index in
                self?.baseView.updateUIForSegmentChange(index)
            })
            .disposed(by: disposeBag) 
        
        // 부적 만들기 페이지로 이동
        baseView.moveToMakeCharmButtonView.button.rx
            .tap
            .bind { [weak self] _ in
                let vc = MakeCharmViewController(answer: self?.answer ?? "")
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    private func updateUI(response: AnswerRespons) {
        answer = response.data.clovaMood
        
        baseView.middleView.updateAcionButtonRepeat()
        baseView.middleView.outPutTextView.text = answer
        baseView.moveToMakeCharmButtonView.isHidden = false
    }
}

extension HomeViewController: HomeViewDelegate {
    func moveToView(index: Int) {
        let option = TabBarOption(rawValue: index)
        
        switch option {
        case .totalCharm:
            let vc = TotalCharmViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        case .home:
            let homeViewController = HomeViewController()
            let navigationController = UINavigationController(rootViewController: homeViewController)
            
            if let window = UIApplication.shared.windows.first {
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
            }
        case .myPage:
            let vc = MyPageViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        case .none: break
        }
    }
}

extension HomeViewController: MiddleBaseviewDelegate {
    func actionButtonTapped() {
        guard let message = baseView.middleView.inputTextView.text,
              let character = SegmentedOption(rawValue: self.baseView.segmentedView.segmentControl.selectedSegmentIndex)?.apiName,
              let deviceId = UserDefaults.standard.string(forKey: "deviceId")
        else { return }
        
        let messageRequest = MessageRequest(message: message,
                                            deviceId: deviceId,
                                            character: character)
        
        ClovaAPIService.share.submitMessage(request: messageRequest) { result in
            switch result {
            case .success(let messageResponse):
                self.updateUI(response: messageResponse)
            case .failure(let error):
                print(error)
                // 기획자님 메세지 확인할 것
                self.showAlertOneButton(title: "", message: "한 번 더")
                self.baseView.middleView.toggleActionButton(.selected)
            }
        }
    }
}
