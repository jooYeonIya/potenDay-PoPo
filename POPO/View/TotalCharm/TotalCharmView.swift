//
//  TotalCharmView.swift
//  POPO
//
//  Created by 강주연 on 7/25/24.
//

import UIKit
import SnapKit

protocol TotalCharmViewDelegate: AnyObject {
    func moveToMakeCharmView(image: UIImage)
}

class TotalCharmView: BaseView {
    
    lazy var titleView = TitleView(title: "행운 부적 모음집")
    lazy var blurImageView = CustomImageView("BlurView")
    lazy var noDataView = NoDataView(message: "앗! 아직 행운 부적이 없잖아? \n 어서 가서 만들어봐!")
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(TotalCharmCollectionViewCell.self, 
                                forCellWithReuseIdentifier: "TotalCharmCollectionViewCell")
        
        return collectionView
    }()
    
    weak var delegate: TotalCharmViewDelegate?
    var images: [UIImage] = [] {
        didSet {
            collectionView.reloadData()
            noDataView.isHidden = !images.isEmpty
        }
    }
    
    override func configure() {
        super.configure()
        backgroundColor = .userGray(9)
    }
    
    override func setupUI() {
        addSubviews([titleView, noDataView, collectionView, blurImageView])
        noDataView.configure()
    }
    
    func getImagesFromFolder() {
        let fileManager = FileManager.default
        let documentsDirectory = getDocumentsDirectory()

        let poPoDirectory = documentsDirectory.appendingPathComponent("PoPo")
        
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: poPoDirectory, includingPropertiesForKeys: nil)
            
            for fileURL in fileURLs {
                if let image = UIImage(contentsOfFile: fileURL.path) {
                    images.append(image)
                }
            }
        } catch {
            print("PoPo 폴더의 이미지 로드 실패: \(error.localizedDescription)")
        }
    }

    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    override func setupLayout() {
        titleView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(80)
        }
        
        blurImageView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(40)
        }

        noDataView.snp.makeConstraints { make in
            make.width.equalTo(290)
            make.height.equalTo(310)
            make.center.equalTo(collectionView)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}

extension TotalCharmView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TotalCharmCollectionViewCell", for: indexPath) as? TotalCharmCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.configure(images[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 2) - 16
        let height = width * 1.8
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        delegate?.moveToMakeCharmView(image: image)
    }
}
