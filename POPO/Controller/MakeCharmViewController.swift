//
//  MakeCharmViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/22/24.
//

import UIKit
import RxSwift
import RxCocoa


class MakeCharmViewController: UIViewController {
    lazy var baseView = MakeCharmView()
    
    let disposeBag = DisposeBag()
        
    override func loadView() {
        super.loadView()
        view = baseView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        baseView.configure()
    }
}
