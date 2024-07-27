//
//  MakeCharmViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/25/24.
//

import UIKit
import RxSwift
import RxCocoa
import Photos

class MakeCharmViewController: BaseViewController {

    lazy var baseView = MakeCharmView()
    
    private let disposeBag = DisposeBag()
    private var answer = ""
    private var image: UIImage?
    
    init(answer: String, image: UIImage?) {
        self.answer = answer
        self.image = image
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
        
        if answer == "total" {
            baseView.cardImageView.image = image
        } else {
            makeCharmMessage()
        }
        
        if UserDefaults.standard.bool(forKey: "isOnboardingCompleted") {
            baseView.toolTipView.isHidden = true
            baseView.toolTipViewLabel.isHidden = true
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                self.baseView.toolTipView.isHidden = true
                self.baseView.toolTipViewLabel.isHidden = true
            }
        }
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    
    override func setupEvent() {
        // 공유 버튼 누르기
        baseView.shareButton.rx
            .tap
            .bind { [weak self] _ in
                self?.shareButtonTapped()
            }
            .disposed(by: disposeBag)
        
        // 저장 버튼 누르기
        baseView.saveButton.rx
            .tap
            .bind { [weak self] _ in
                self?.saveButtonTapped()
            }
            .disposed(by: disposeBag)
        
        // 돌아가기 버튼 누르기
        baseView.rightArrowButton.rx
            .tap
            .bind { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
        
        // 팝업 클로즈 버튼 누르기
        baseView.popupView.closeButton.rx
            .tap
            .bind { [weak self] in
                self?.baseView.shadowBackgroundView.isHidden = true
                self?.baseView.popupView.isHidden = true
            }
            .disposed(by: disposeBag)
        
        // 팝업 처음으로 버튼 누르기
        baseView.popupView.moveToHomeBUtton.rx
            .tap
            .bind { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    // 공유 버튼 누르기
    private func shareButtonTapped() {
        guard let shareImgae = baseView.cardImageView.image else { return }

        let activityViewController = UIActivityViewController(activityItems: [shareImgae], applicationActivities: nil)
        
        // pop되게 만듦
        if let popoverController = activityViewController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        // 표시
        present(activityViewController, animated: true, completion: nil)
    }
    
    // 저장 버튼 누르기
    private func saveButtonTapped() {
        guard let image = baseView.cardImageView.image else { return }

        // 사진첩 접근 권한 상태 확인 및 요청
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                switch status {
                case .authorized, .limited:
                    self.saveImageToPhotoLibrary(image)
                case .denied, .restricted:
                    self.showAlertOneButton(title: "", message: "사진첩 접근 권한이 필요합니다.")
                case .notDetermined:
                    // 권한이 아직 결정되지 않은 경우 처리
                    print("사진첩 접근 권한이 결정되지 않았습니다.")
                @unknown default:
                    fatalError("새로운 상태가 추가되었습니다.")
                }
            }
        }
    }

    private func saveImageToPhotoLibrary(_ image: UIImage) {
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.creationRequestForAsset(from: image)
        }, completionHandler: { success, error in
            if success {
                print("이미지가 사진첩에 저장되었습니다.")
            } else {
                print("이미지 저장에 실패했습니다: \(String(describing: error))")
            }
        })
    }

    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            baseView.shadowBackgroundView.isHidden = true
            baseView.popupView.isHidden = true
            print("이미지가 사진첩에 저장되었습니다.")
        }
    }
}


