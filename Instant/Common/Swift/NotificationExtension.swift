//
//  NotificationToos.swift
//  HospitalWorkStation
//
//  Created by 吴远房 on 2019/8/13.
//  Copyright © 2019 吴远房. All rights reserved.
//

import UIKit

extension Notification.Name {
    
    // 根目录发生改变时，发送的通知
    static let rootChangeNotifi = Notification.Name(rawValue: "RootViewCtonrollerChangeNotification")
    
    // 根目录发生改变时，发送的通知
    static let tabBarChangeNotifi = Notification.Name(rawValue: "TabBarChangeNotification")
    
    // 修改接单状态
    static let chageAcceptStatus = Notification.Name(rawValue: "ChageAcceptStatus")
    
    // 
    static let changeHomeData = Notification.Name(rawValue: "ChangeHomeData")
}

