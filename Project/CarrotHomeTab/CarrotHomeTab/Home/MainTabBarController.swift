//
//  MainTabBarController.swift
//  CarrotHomeTab
//
//  Created by 박성준 on 2023/12/28.
//

import UIKit

class MainTabBarController: UITabBarController {

    // Tab이 눌릴 때마다 앱의 좌상단에 Title과 우상단에 Icon이 변경
    // - Tab이 눌리는 것을 감지
    // - 감지후에, 그 탭에 맞게 네비게이션 바 구성 및 업데이트
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    // 초기 앱 진입후에 View Controller에 따라 Navigation Item 업데이트
    private func updateNavigationItem(viewController: UIViewController) {
        
    }
}

// 각 탭에 맞게 네비게이션 바 구성 [✅]
// 홈: 타이틀 - 피드, 서치 ✅
// 동네 활동: 타이틀 - 피드 ✅
// 내 근처: 타이틀 ✅
// 채팅: 타이틀 - 피드 ✅
// 나의 당근: 타이틀 - 설정 ✅
extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("\(viewController) Tabbed")
        
        switch viewController {
        case is HomeViewController:
            let titleConfig = CustomBarItemConfigure(title: "심곡동", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let searchConfig = CustomBarItemConfigure(
                image: UIImage(systemName: "magnifyingglass"),
                handler: {}
            )
            let searchItem = UIBarButtonItem.generate(with: searchConfig, width: 30)
            
            let feedConfig = CustomBarItemConfigure(
                image: UIImage(systemName: "bell"),
                handler: {}
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [searchItem, feedItem]
            
        case is MyTownViewController:
            let titleConfig = CustomBarItemConfigure(title: "심곡동", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let feedConfig = CustomBarItemConfigure(
                image: UIImage(systemName: "bell"),
                handler: {}
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            
        case is ChatViewController:
            let titleConfig = CustomBarItemConfigure(title: "채팅", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let feedConfig = CustomBarItemConfigure(
                image: UIImage(systemName: "bell"),
                handler: {}
            )
            let feedItem = UIBarButtonItem.generate(with: feedConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [feedItem]
            
        case is MyProfileViewController:
            let titleConfig = CustomBarItemConfigure(title: "나의 당근", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            let settingConfig = CustomBarItemConfigure(
                image: UIImage(systemName: "gearshape"),
                handler: {}
            )
            let settingItem = UIBarButtonItem.generate(with: settingConfig, width: 30)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = [settingItem]
            
        default:
            let titleConfig = CustomBarItemConfigure(title: "나의 당근", handler: { })
            let titleItem = UIBarButtonItem.generate(with: titleConfig)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItems = []
        }
    }
}
