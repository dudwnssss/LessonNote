//
//  MainTabBarController.swift
//  LessonNote
//
//  Created by 임영준 on 2023/10/01.
//

import UIKit

class MainTabBarContorller: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewContollers()
        tabBar.tintColor = Color.black
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
