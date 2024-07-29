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
        let vc = MakeCharmViewController(answer: "total", image: image)
        navigationController?.pushViewController(vc, animated: true)
    }
}
