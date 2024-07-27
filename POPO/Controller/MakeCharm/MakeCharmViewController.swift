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
    private var answer = ""
    
    init(answer: String) {
        self.answer = answer
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
        
        guard let deviceId = UserDefaults.standard.string(forKey: "deviceId") else { return }
        let request = CharmRequest(message: answer, deviceId: deviceId)
        
        ClovaAPIService.share.fetchCharm(request: request) { result in
            switch result {
            case .success(let response):
                self.makeCharmImgae(message: [response.data.fourIdioms, response.data.message])
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func makeCharmImgae(message: [String]) {
        let message1 = message[0]
        let message2 = message[1]
        
        baseView.message1 = message1
        baseView.message2 = message2
        
        baseView.makeCharmImage()
    }
}
