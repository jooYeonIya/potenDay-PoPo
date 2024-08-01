//
//  TotalCharmViewController.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit

class TotalCharmViewController: BaseViewController {
    
    lazy var baseView = TotalCharmView()

    override func loadView() {
        super.loadView()
        view = baseView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        baseView.configure()
        baseView.delegate = self
        baseView.getImagesFromFolder()
    }
}

extension TotalCharmViewController: TotalCharmViewDelegate {
    func moveToMakeCharmView(image: UIImage) {
        let nextVC = MakeCharmViewController(answer: "total", image: image)
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
