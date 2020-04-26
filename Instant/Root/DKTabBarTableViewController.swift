//
//  DKTabBarTableViewController.swift
//  Instant
//
//  Created by yuanfang wu on 2020/4/26.
//  Copyright © 2020 yuanfang wu. All rights reserved.
//

import UIKit

class DKTabBarTableViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.setupChildController()
        self.tabBar.tintColor = AppThemeColor
    }
    
    // 初始化4个Controller
    func setupChildController() {
        // 首页
        let homeVC = DKHomeViewController()
        self.setupChildViewController(controller: homeVC, title: "时刻", imageName: "icon_home_normal", selectImageName: "icon_home_click", tag: 10)
        // 我的
        let mineVC = DKMineViewController()
        self.setupChildViewController(controller: mineVC, title: "我的", imageName: "icon_me_normal", selectImageName: "icon_me_click", tag: 13)
        
    }
    
    func setupChildViewController(controller:UIViewController, title:String, imageName:String, selectImageName:String, tag:Int) {
        let nav : DKNavigationViewController = DKNavigationViewController.init(rootViewController: controller)
        nav.tag = tag
        nav.tabBarItem.title = title
        nav.tabBarItem.tag = tag;
        nav.tabBarItem.image = UIImage.init(named: imageName)?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = UIImage.init(named: selectImageName)?.withRenderingMode(.alwaysOriginal)
        self.addChild(nav)
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        DKUserInfo.shared.animated = false
    }
    
    
}

extension DKTabBarTableViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
}
