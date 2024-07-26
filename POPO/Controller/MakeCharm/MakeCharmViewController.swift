//
//  MakeCharmViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/25/24.
//

import UIKit
import RxSwift
import RxCocoa

class MakeCharmViewController: BaseViewController {

    lazy var baseView = MakeCharmView()
    
    private let disposeBag = DisposeBag()
    private var message = ""
    
    init(message: String) {
        self.message = message
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.configure()
        
        makeCharmMessage()
 
    }
    
    private func makeCharmMessage() {
        // 받아 온 데이터를 뷰에 넘겨주고
        // 뷰에서는 합성
        // 화면에 보여주기
//        ClovaAPIService.share.fetchCharm { result in
//            switch result {
//            case .success(let response):
//                print(response)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        let message1 = "으하하하"
        let message2 = "복숭아는 맛있어 달고 맛있어 며칠 전에 복숭아 싸게 샀잖아 럭키비키잖아"
        
        baseView.message1 = message1
        baseView.message2 = message2
        
        baseView.makeCharmImage()
                        
        
    }
    
    override func setupEvent() {
        baseView.closeButton.rx
            .tap
            .bind { [weak self] _ in
                self?.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
    }
}
