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
    // 컴포넌트
    lazy var baseView = HomeBaseView(option: .popo)
    
    // 변수
    private let disposeBag = DisposeBag()
    
    var answer = ""
    
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
        toggleToolTip()
    }

    // 툴팁 관련
    func toggleToolTip() {
        if UserDefaults.standard.bool(forKey: "isHomeToolTipShow") {
            self.baseView.toolTipView.isHidden = true
            self.baseView.toolTipViewTextLabel.isHidden = true
        } else {
            baseView.toolTipView.isHidden = false
            baseView.toolTipViewTextLabel.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.baseView.toolTipView.isHidden = true
                self.baseView.toolTipViewTextLabel.isHidden = true
            }
            
            UserDefaults.standard.setValue(true, forKey: "isHomeToolTipShow")
        }
    }
    
    override func setupEvent() {
        // 세그먼티트 컨트롤러 탭했을 때
        baseView.segmentedControl.rx
            .selectedSegmentIndex
            .bind { [weak self] index in
                
                if self?.baseView.middleView.actionButton.titleLabel?.text == "다시하기" {
                    self?.baseView.moveToMakeCharmViewButton.isHidden = true
                    self?.baseView.middleView.toggleActionButton(.selected)
                }
                
                guard let option = SegmentedOption(rawValue: index) else { return }
                self?.baseView.updateUIForSegmenteCotrol(option)
            }
            .disposed(by: disposeBag)
        
        // 얍 버튼 탭했을 때
        baseView.middleView.actionButton.rx
            .tap
            .bind { [weak self] _ in
                guard let buttonTag = self?.baseView.middleView.actionButton.tag,
                      let buttonAction = ActionButtonOtpion(rawValue: buttonTag) else { return }
                switch buttonAction {
                case .selected: 
                    self?.baseView.middleView.toggleActionButton(.loading)
                    self?.yaapButtonTapped()
                case .retry:
                    self?.retryButtonTapped()
                case .deselected, .loading: break
                }
            }
            .disposed(by: disposeBag)
        
        // 부적 만들기 버튼 탭했을 때
        baseView.moveToMakeCharmViewButton.rx
            .tap
            .bind { [weak self] _ in
                self?.moveToMakeCharmViewButtonTapped()
            }
            .disposed(by: disposeBag)

    }
    
    // 얍 버튼
    func yaapButtonTapped() {
        guard let deviceId = UserDefaults.standard.string(forKey: "deviceId"),
        let option = SegmentedOption(rawValue: baseView.segmentedControl.selectedSegmentIndex) else { return }
        
        let messageRequest = MessageRequest(message: baseView.middleView.inputTextView.text,
                                            deviceId: deviceId,
                                            character: option.apiName)
        
        ClovaAPIService.share.submitMessage(request: messageRequest) { result in
            switch result {
            case .success(let response):
                self.baseView.moveToMakeCharmViewButton.isHidden = false
                self.baseView.middleView.updateUIForYaapButtonTppaed(response.data.clovaMood)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // 다시하기 버튼
    func retryButtonTapped() {
        baseView.configure()
        baseView.middleView.option = .popo
        baseView.middleView.configure()
    }
    
    // 부적 만들기 버튼
    func moveToMakeCharmViewButtonTapped() {
        let nextVC = MakeCharmViewController(answer: answer, image: nil)
        nextVC.modalPresentationStyle = .fullScreen
        addChild(nextVC)
        
        // x축을 view의 넓이만큼 오른쪽으로 이동시킨다. 뷰|뷰 이런 상태가 되어 있음.
        nextVC.view.frame = view.frame.offsetBy(dx: view.frame.width, dy: 0)
        view.addSubview(nextVC.view)
        
        UIView.animate(withDuration: 0.5, animations: {
            // 뷰의 프레임을 중심으로 이동시킨다.
            nextVC.view.frame = self.view.frame
        }) { _ in
            nextVC.didMove(toParent: self)
        }
    }
 }
