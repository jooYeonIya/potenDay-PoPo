//
//  MakeCharmView.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/25/24.
//

import UIKit

class MakeCharmView: BaseView {

    lazy var titleView = TitleView(title: "행운부적")
    let cardImageView = UIImageView(image: UIImage(named: "DummyCharm"))
    let bottomLabel = UILabel()
    let closeButton = UIButton(type: .system)
    let saveButton = UIButton(type: .system)
    let shareButton = UIButton()
    
    
    override func configure() {
        super.configure()
        backgroundColor = .userLightGreen
    }
    
    override func setupUI() {
        addSubviews([titleView, cardImageView, bottomLabel, saveButton, closeButton, shareButton])

        cardImageView.contentMode = .scaleAspectFit
        cardImageView.layer.shadowColor = UIColor.userGray(1).cgColor
        cardImageView.layer.shadowOpacity = 0.4
        cardImageView.layer.shadowRadius = 10
        cardImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        // 이미지 선택은 랜덤(?)
        // 그 이미지에 따라 좌표값과 가로세로 값이 다르기 때문에 어딘가 저장해두는 게 좋을 것 같다
        makeCharmImage()
        
        bottomLabel.text = "다음 버스가 빨리 오기를 빌어줄게!🍀"
        bottomLabel.font = .body(ofSize: 15)
        bottomLabel.textColor = .userGray(1)
        
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(named: "Clover_Selected")
        configuration.imagePadding = 4
        configuration.background.image = UIImage(named: "SaveButton")
        
        let attributedString = NSAttributedString(string: "저장하기", attributes: [.font: UIFont.body(ofSize: 15), .foregroundColor: UIColor.userGray(1)])
        configuration.attributedTitle = AttributedString(attributedString)
        
        saveButton.configuration = configuration
        
        var closeConfiguration = UIButton.Configuration.plain()
        closeConfiguration.image = UIImage(named: "Close")
        closeConfiguration.imagePadding = 4
        
        let closeAttributedString = NSAttributedString(string: "닫기", attributes: [.font: UIFont.body(ofSize: 15), .foregroundColor: UIColor.userGray(4)])
        closeConfiguration.attributedTitle = AttributedString(closeAttributedString)
        
        closeButton.configuration = closeConfiguration
        
        shareButton.setBackgroundImage(UIImage(named: "ShareButton"), for: .normal)
    }
    
    override func setupLayout() {

        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }

        cardImageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.width.equalTo(270)
            make.height.equalTo(480)
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.top.equalTo(cardImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(bottomLabel.snp.bottom).offset(24)
            make.height.equalTo(80)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.top)
            make.trailing.equalTo(saveButton.snp.leading).offset(-8)
            make.leading.equalToSuperview().offset(32)
            make.width.height.equalTo(80)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalTo(saveButton.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
    }
    
    private func makeCharmImage() {
        guard let image = UIImage(named: "CharmVer1") else { return }
        let text1 = "코드무쌍"
        let text2 = "긴장속에서 원하는 대학의 합격을 바랄 수 있을 거야"
        
        let textColor = UIColor.black
        
        // 행간 설정
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20
        
        // 자간 및 행간을 포함한 속성 설정
        let attributedString1 = NSAttributedString(string: text1, attributes: [
            .font: UIFont.bodyBold(ofSize: 108),
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
            .kern: 1.5
        ])
        
        let attributedString2 = NSAttributedString(string: text2, attributes: [
            .font: UIFont.bodyBold(ofSize: 68),
            .foregroundColor: textColor,
            .paragraphStyle: paragraphStyle,
        ])
        
        let textRect1 = CGRect(x: 173, y: 1564, width: 736, height: 160)
        let textRect2 = CGRect(x: 180, y: 737, width: 720, height: 540)
        
        // 텍스트와 위치 배열 생성
        let texts = [(text: attributedString1, rect: textRect1), (text: attributedString2, rect: textRect2)]
        
        // 이미지와 텍스트 합성
        let combinedImage = drawTextsOnImage(image: image, texts: texts)
        
        // 이미지뷰에 이미지 표시
        cardImageView.image = combinedImage

        // 이미지 저장 (JPEG 형식)
        if let data = combinedImage.jpegData(compressionQuality: 0.8) {
            let UUID = UUID()
            let filename = getDocumentsDirectory().appendingPathComponent("\(UUID).jpg")
            try? data.write(to: filename)
//            print("Image saved to \(filename.path)")
        }
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
