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
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
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
    }
    
    // 얍 버튼
    func yaapButtonTapped() {
        let answer = AnswerData(clovaMood: "테스트 중", character: "POPO")
        let response = AnswerRespons(data: answer, code: 200, message: "성공")
        
        baseView.moveToMakeCharmViewButton.isHidden = false        
        baseView.middleView.updateUIForYaapButtonTppaed(response.data.clovaMood)
    }
    
    // 다시하기 버튼
    func retryButtonTapped() {
        baseView.configure()
        baseView.middleView.option = .popo
        baseView.middleView.configure()
    }
 }
