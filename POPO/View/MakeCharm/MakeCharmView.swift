//
//  MakeCharmView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/25/24.
//

import UIKit

class MakeCharmView: BaseView {

    lazy var titleView = TitleView(title: "행운부적")
    lazy var cardImageView = UIImageView(image: UIImage())
    lazy var cardImageShadowView = UIView()
    lazy var saveButton = UIButton()
    lazy var shareButton = UIButton()
    
    var message1 = ""
    var message2 = ""
    
    override func configure() {
        super.configure()
    }
    
    override func setupUI() {
        addSubviews([titleView, cardImageShadowView, cardImageView, saveButton, shareButton])
        
        backgroundColor = .userGray(9)

        cardImageView.contentMode = .scaleAspectFit
        cardImageView.layer.cornerRadius = 17
        cardImageView.clipsToBounds = true
    
        cardImageShadowView.backgroundColor = .userGray(9)
        cardImageShadowView.layer.shadowOpacity = 0.4
        cardImageShadowView.layer.shadowRadius = 10
        cardImageShadowView.layer.shadowColor = UIColor.userGray(1).cgColor
//        cardImageShadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cardImageShadowView.layer.cornerRadius = 17
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "Clover_Selected")
        configuration.imagePadding = 4
        configuration.background.image = UIImage(named: "SaveButton")
        
        let attributedString = NSAttributedString(string: "저장하기", attributes: [.font: UIFont.bodyBold(ofSize: 15), .foregroundColor: UIColor.userGray(1)])
        configuration.attributedTitle = AttributedString(attributedString)
        
        saveButton.configuration = configuration
        
        shareButton.setBackgroundImage(UIImage(named: "ShareButton"), for: .normal)
    }
    
    override func setupLayout() {
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
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
    }
    
    func makeCharmImage() {
        let number = Int.random(in: 0...6)
        
        guard let charmImage = Images(rawValue: number), let image = UIImage(named: charmImage.name) else { return }
               
        let text1 = message1
        let text2 = message2
        
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
//        if let data = combinedImage.jpegData(compressionQuality: 0.8) {
//            let UUID = UUID()
//            let filename = getDocumentsDirectory().appendingPathComponent("\(UUID).jpg")
//            try? data.write(to: filename)
//            print("Image saved to \(filename.path)")
//        }
        
        // 이미지를 사진첩에 저장
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
    
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
