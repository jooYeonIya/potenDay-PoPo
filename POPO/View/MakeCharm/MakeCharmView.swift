//
//  MakeCharmView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/25/24.
//

import UIKit

class MakeCharmView: BaseView {
    
    // 상단
    lazy var titleView = TitleView(title: "행운부적")
    lazy var leftArrowButton = UIButton()
    
    // 툴팁
    lazy var toolTipView = CustomImageView("GrayToolTip")
    lazy var toolTipViewLabel = CustomLabel(text: "부적을 저장해서 배경화면으로 활용해봐!", font: .body(ofSize: 11))
    
    // 부적 이미지
    lazy var cardImageView = UIImageView(image: UIImage())
    lazy var cardImageShadowView = UIView()
    
    // 버튼
    lazy var saveButton = UIButton()
    lazy var shareButton = UIButton()
    
    // 저장 완료 뷰
    lazy var shadowBackgroundView = UIView()
    lazy var popupView = PopupView()
    
    var cardImage: UIImage?
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubviews([titleView, 
                     leftArrowButton,
                     cardImageShadowView,
                     cardImageView,
                     saveButton,
                     toolTipView,
                     shareButton,
                     shadowBackgroundView,
                     popupView])
        
        backgroundColor = .userGray(9)
        
        leftArrowButton.setImage(UIImage(named: "LeftArrowButton"), for: .normal)

        cardImageView.contentMode = .scaleAspectFit
        cardImageView.layer.cornerRadius = 17
        cardImageView.clipsToBounds = true
        cardImageView.image = cardImage == nil ? UIImage(named: "ImageLoading") : cardImage
    
        cardImageShadowView.backgroundColor = .userGray(9)
        cardImageShadowView.layer.shadowOpacity = 0.4
        cardImageShadowView.layer.shadowRadius = 10
        cardImageShadowView.layer.shadowColor = UIColor.userGray(1).cgColor
        cardImageShadowView.layer.cornerRadius = 17
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "Clover_Selected")
        configuration.imagePadding = 4
        configuration.background.image = UIImage(named: "SaveButton")
        
        let attributedString = NSAttributedString(string: "저장하기", 
                                                  attributes: [.font: UIFont.bodyBold(ofSize: 15),
                                                    .foregroundColor: UIColor.userGray(1)])
        configuration.attributedTitle = AttributedString(attributedString)
        
        saveButton.configuration = configuration
        
        shareButton.setBackgroundImage(UIImage(named: "ShareButton"), for: .normal)
        
        toolTipView.addSubview(toolTipViewLabel)
        
        // 저장 완료 화면
        shadowBackgroundView.backgroundColor = .black
        shadowBackgroundView.alpha = 0.5
        
        popupView.configure()
        
        // 로딩 화면에서는 안 보이는 것들
        shadowBackgroundView.isHidden = true
        popupView.isHidden = true
        toolTipView.isHidden = true
        
        saveButton.isHidden = cardImage == nil
        shareButton.isHidden = cardImage == nil
    }
    
    override func setupLayout() {
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        leftArrowButton.snp.makeConstraints { make in
            make.width.height.equalTo(24)
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalTo(titleView)
        }
        
        cardImageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.width.equalTo(320)
            make.height.equalTo(560)
        }
        
        cardImageShadowView.snp.makeConstraints { make in
            make.width.equalTo(310)
            make.height.equalTo(550)
            make.edges.equalTo(cardImageView)
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(cardImageView.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(60)
            make.width.equalTo(240)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.top)
            make.trailing.equalTo(saveButton.snp.leading).offset(-8)
            make.leading.equalToSuperview().offset(38)
            make.width.height.equalTo(60)
        }
        
        toolTipView.snp.makeConstraints { make in
            make.bottom.equalTo(saveButton.snp.top).offset(16)
            make.trailing.equalToSuperview().offset(-56)
            make.width.equalTo(200)
        }
        
        toolTipViewLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-4)
            make.centerX.equalToSuperview()
        }
        
        shadowBackgroundView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        popupView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
    }
    
    // 부적 만들기
    func makeCharmImage(with messages: [String]) {
        let number = Int.random(in: 0...6)
        
        guard let charmImage = Images(rawValue: number), 
                let image = UIImage(named: charmImage.name) else { return }
               
        let text1 = messages[0]
        let text2 = messages[1]
        
        let textColor = UIColor.black
        
        // 행간 설정
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .center
        
        // 자간 및 행간을 포함한 속성 설정
        let attributedString1 = NSAttributedString(string: text1 , attributes: [
            .font: UIFont.point(ofSize: 108),
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
            .kern: 64.8
        ])
        
        let attributedString2 = NSAttributedString(string: text2 , attributes: [
            .font: UIFont.point(ofSize: 68),
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
        ])
        
        let point1 = charmImage.coordinates.coord1
        let point2 = charmImage.coordinates.coord2
        
        let textRect1 = CGRect(x: point1.x, y: point1.y, width: 736, height: 160)
        let textRect2 = CGRect(x: point2.x, y: point2.y, width: 720, height: 540)
        
        // 텍스트와 위치 배열 생성
        let texts = [(text: attributedString1, rect: textRect1), (text: attributedString2, rect: textRect2)]
        
        // 이미지와 텍스트 합성
        let combinedImage = drawTextsOnImage(image: image, texts: texts)
        
        // 이미지뷰에 이미지 표시
        cardImageView.image = combinedImage

        // 이미지 저장 (JPEG 형식)
//        saveImageToFolder(combinedImage) {
//            self.loadingImageView.isHidden = true
//            self.saveButton.isHidden = false
//            self.shareButton.isHidden = false
//            
        if UserDefaults.standard.bool(forKey: "isDonwloadToolTipShow") {
            self.toolTipView.isHidden = true
            self.toolTipViewLabel.isHidden = true
            
            UserDefaults.standard.setValue(true, forKey: "isDonwloadToolTipShow")
        } else {
            self.toolTipView.isHidden = false
            self.toolTipViewLabel.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.toolTipView.isHidden = true
                self.toolTipViewLabel.isHidden = true
            }
        }
        //        }
    }
        
    private func drawTextsOnImage(image: UIImage, texts: [(text: NSAttributedString, rect: CGRect)]) -> UIImage {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)
        
        image.draw(at: CGPoint.zero)
        
        for (attributedText, textRect) in texts {
            attributedText.draw(in: textRect)
        }
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return resultImage!
    }
    
    private func saveImageToFolder(_ combinedImage: UIImage, completion: (() -> Void)? = nil)  {
        // 이미지 데이터를 JPEG 형식으로 압축
        if let data = combinedImage.jpegData(compressionQuality: 0.8) {
            
            // PoPo 폴더 경로 설정
            let fileManager = FileManager.default
            let documentsDirectory = getDocumentsDirectory()
            let poPoDirectory = documentsDirectory.appendingPathComponent("PoPo")

            // PoPo 폴더가 존재하지 않을 경우 폴더 생성
            if !fileManager.fileExists(atPath: poPoDirectory.path) {
                do {
                    try fileManager.createDirectory(at: poPoDirectory, withIntermediateDirectories: true, attributes: nil)
                } catch {
                    print("폴더 생성 실패: \(error.localizedDescription)")
                    return
                }
            }

            // 파일 이름 및 경로 설정
            let uuid = UUID().uuidString
            let filename = poPoDirectory.appendingPathComponent("\(uuid).jpg")

            // 이미지 데이터를 파일에 저장
            do {
                try data.write(to: filename)
                print("Image saved to \(filename.path)")
                completion?()
            } catch {
                print("이미지 저장 실패: \(error.localizedDescription)")
            }
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
