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
        let titleItem = UIBarButtonItem(title: "심곡동", style: .plain, target: nil, action: nil)
        let feedItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
        
        navigationItem.leftBarButtonItem = titleItem
        navigationItem.rightBarButtonItem = feedItem
        
        super.viewDidLoad()
        delegate = self
    }
}

extension MainTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("\(viewController) Tabbed")
        
        switch viewController {
        case is HomeViewController:
            let titleConfig = CustomBarItemConfigure(title: "심곡동", handler: { })
            let customTitleView = CustomBarItem(config: titleConfig)
            let titleItem = UIBarButtonItem(customView: customTitleView)
            
            let feedConfig = CustomBarItemConfigure(image: UIImage(systemName: "magnifyingglass") ,handler: {})
            let customFeedView = CustomBarItem(config: feedConfig)
            let feedItem = UIBarButtonItem(customView: customFeedView)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItem = feedItem
        case is MyTownViewController:
            let titleItem = UIBarButtonItem(title: "심곡동", style: .plain, target: nil, action: nil)
            let feedItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItem = feedItem
        case is ChatViewController:
            let titleItem = UIBarButtonItem(title: "채팅", style: .plain, target: nil, action: nil)
            let feedItem = UIBarButtonItem(barButtonSystemItem: .action, target: nil, action: nil)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItem = feedItem
        case is MyProfileViewController:
            let titleItem = UIBarButtonItem(title: "나의 당근", style: .plain, target: nil, action: nil)
            let feedItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItem = feedItem
        default:
            let titleItem = UIBarButtonItem(title: "둘러 보기", style: .plain, target: nil, action: nil)
            let feedItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: nil)
            
            navigationItem.leftBarButtonItem = titleItem
            navigationItem.rightBarButtonItem = feedItem
        }
    }
}
