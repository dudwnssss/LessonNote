//
//  MainTabBarController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

final class MainTabBarContorller: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewContollers()
        setupTabbarUI()
    }
    
}

extension MainTabBarContorller{
    
    private func setViewContollers(){
        let homeVC = HomeViewController()
        let homeNavigationController = UINavigationController(rootViewController: homeVC)
        homeNavigationController.tabBarItem = UITabBarItem(title: nil,
                                                           image: Tab.home.image,
                                                           selectedImage: Tab.home.selectedImage)
        
        let scheduleVC = ScheduleViewController()
        let scheduleNavigationController = UINavigationController(rootViewController: scheduleVC)
        scheduleNavigationController.tabBarItem = UITabBarItem(title: nil,
                                                               image: Tab.schedule.image,
                                                               selectedImage: Tab.schedule.selectedImage)
        
        super.setViewControllers([
        homeNavigationController,
        scheduleNavigationController
        ], animated: true)
    }
    
}

extension MainTabBarContorller {
    private func setupTabbarUI() {
        tabBar.tintColor = Color.black
        setTabBarItemImageInsets()
    }
    
    func setTabBarItemImageInsets() {
        viewControllers?.forEach {
            if $0.tabBarItem.title == nil {
                $0.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            }
        }
    }
}
