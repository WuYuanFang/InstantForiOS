//
//  DKNavigationViewController.swift
//  CattleMaster
//
//  Created by wuyuanfang on 2019/11/22.
//  Copyright © 2019 CattleMaster. All rights reserved.
//

import UIKit

class DKNavigationViewController: UINavigationController {
    
    var tag:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isTranslucent = false
        self.navigationBar.tintColor = UIColor.white
        self.navigationBar.barTintColor = AppThemeColor
        self.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, .font:UIFont.systemFont(ofSize: 18)]
    }
    
    // 当在首页跳转的话，需要先隐藏UITabbar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    
}
