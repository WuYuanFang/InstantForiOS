//
//  AppDelegate.swift
//  Instant
//
//  Created by yuanfang wu on 2020/4/26.
//  Copyright © 2020 yuanfang wu. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 设置根页面改变的通知
        NotificationCenter.default.addObserver(self, selector: #selector(resetRootVCNotification), name: .rootChangeNotifi, object: nil)
        
        window = UIWindow.init()
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        window?.rootViewController = DK_WelcomeViewController()
        UINavigationBar.appearance().isTranslucent = false
        return true
    }
    
    /// 根页面改变的通知方法
    @objc func resetRootVCNotification(_ notifi:Notification) {
        guard let status = notifi.object as? RootStatus else {
            return
        }
        switch status {
        case .login:
            let loginVC = DKLoginViewController()
            let loginNav = DKNavigationViewController.init(rootViewController: loginVC)
            self.window?.rootViewController = loginNav
        case .home:
            window?.rootViewController = DKTabBarTableViewController()
        }
    }


}

