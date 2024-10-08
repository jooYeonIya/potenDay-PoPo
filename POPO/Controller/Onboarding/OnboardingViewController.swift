//
//  OnboardingViewController.swift
//  POPO
//
//  Created by Jooyeon Kang on 7/24/24.
//

import UIKit
import RxSwift
import RxCocoa

class OnboardingViewController: BaseViewController {
    
    // 컴포넌트
    lazy var pageControl = UIPageControl()
    
    // 변수
    private var pageViewController: UIPageViewController!
    private var pages: [UIViewController] = []
    private let disposeBag = DisposeBag()
    
    let nameViewController = NameViewController()
    let ageViewController = AgeViewController()
    
    private var selectedAge: Int?
    private var pressedName: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupLayout()
    }

    // Setup UI
    private func setupUI() {
        view.backgroundColor = .userLightGreen
        
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pages = [nameViewController, ageViewController]
    
        if let firstViewController = pages.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true)
        }
        
        setupPageControl()
        
        addChild(pageViewController)
        view.addSubviews([pageControl, pageViewController.view])
        pageViewController.didMove(toParent: self)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = 2
        pageControl.currentPage = 0
        pageControl.allowsContinuousInteraction = false
        pageControl.isUserInteractionEnabled = false
        pageControl.currentPageIndicatorTintColor = .userGreen
        pageControl.pageIndicatorTintColor = .userGray(4)
        
        let indicatorImage = UIImage(named: "Indicator")
        pageControl.setIndicatorImage(indicatorImage, forPage: 0)
        pageControl.setIndicatorImage(indicatorImage, forPage: 1)
    }
    
    override func setupEvent() {
        nameViewController.enterPressedSubject
            .bind { [weak self] text in
                self?.pressedName = text
                self?.moveToAgePageView()
            }
            .disposed(by: disposeBag)
        
        ageViewController.selectedAgeSubject
            .bind { [weak self] index in
                self?.selectedAge = index
                self?.ageViewController.baseView.doneButton.isEnabled = true
                self?.ageViewController.baseView.doneButton.applyBlurButton(withImage: UIImage(named:"Clover_Selected")!,
                                                                            withText: "준비 끝",
                                                                            fontSize: 15)
            }
            .disposed(by: disposeBag)
 
        
        ageViewController.baseView.doneButton.rx
            .tap
            .bind { [weak self] _ in
                if self?.pressedName != nil && self?.selectedAge != nil {
                    self?.saveUserInfo()
                } else {
                    self?.showAlertOneButton(title: "", message: "이름을 입력해 주세요")
                }
            }
            .disposed(by: disposeBag)
    }
    
    // Setup Layout
    private func setupLayout() {
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(pageControl.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }

    // 사용자 정보 등록
    private func saveUserInfo() {
        let userName = nameViewController.baseView.nameTextField.text
        let userAge = Ages(rawValue: selectedAge!)?.apiAge
        let UUID = UUID().uuidString
        
        let userInfo = UserInfoRequest(age: userAge!, name: userName!, deviceId: UUID)
        ClovaAPIService.share.saveUserInfo(request: userInfo) { result in
            switch result {
            case .success(_):
                UserDefaults.standard.setValue(UUID, forKey: "deviceId")
                self.moveToHomeView()
            case .failure(_):
                self.showAlertOneButton(title: "", message: "다시 한 번 시도해 주세요")
            }
        }
    }
    
    
    private func moveToHomeView() {
        UserDefaults.standard.setValue(true, forKey: "isOnboardingCompleted")
        UserDefaults.standard.setValue(false, forKey: "isHomeToolTipShow")
        UserDefaults.standard.setValue(false, forKey: "isDonwloadToolTipShow")
        
        let VC = CustomTabBarViewController()
        VC.modalPresentationStyle = .fullScreen
        present(VC, animated: false)
    }
    
    private func moveToAgePageView() {
        guard let currentVC = pageViewController.viewControllers?.first,
               let currentIndex = pages.firstIndex(of: currentVC) else { return }
         
         // 다음 페이지가 있는지 확인
         let nextIndex = currentIndex + 1
         guard nextIndex < pages.count else { return }
         
         // 다음 페이지로 전환
         let nextVC = pages[nextIndex]
         pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    // 이전 페이지의 뷰 컨트롤러를 반환하는 메서드
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        // 현재 뷰 컨트롤러의 인덱스를 찾아서, 인덱스가 0보다 크면 이전 페이지 있음
        guard let index = pages.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        return pages[index - 1]
    }

    // 다음 페이지의 뷰 컨트롤러를 반환하는 메서드
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        // 현재 뷰 컨트롤러의 인덱스를 찾아서 인덱스를 찾아서 페이지 수 - 1보다 작으면 다음 페이지가 있음
        guard let index = pages.firstIndex(of: viewController), index < pages.count - 1 else {
            return nil // 인덱스가 페이지 수 - 1 이상이라면 다음 페이지가 없으므로 nil을 반환합니다.
        }
        return pages[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first, let index = pages.firstIndex(of: currentVC) {
            pageControl.currentPage = index
        }
    }
}
