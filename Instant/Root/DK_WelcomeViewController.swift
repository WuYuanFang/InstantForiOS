//
//  DK_WelcomeViewController.swift
//  Instant
//
//  Created by yuanfang wu on 2020/4/26.
//  Copyright © 2020 yuanfang wu. All rights reserved.
//

import UIKit

class DK_WelcomeViewController: DKBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let userInfo:UserInfoModel = DKCacheManager.shared.getObjectForKeyDirect(CacheType.UserInfo.rawValue), let _ = userInfo.id {
            NotificationCenter.default.post(name: .rootChangeNotifi, object: RootStatus.home)
        }else{
            NotificationCenter.default.post(name: .rootChangeNotifi, object: RootStatus.login)
        }
    }
    

}
