//
//  EnumExtension.swift
//  HospitalWorkStation
//
//  Created by 吴远房 on 2019/10/14.
//  Copyright © 2019 吴远房. All rights reserved.
//
// 所有的枚举类
import UIKit

//MARK: 根目录的跳转类型
enum RootStatus {
    case login                // 前往登录页
    case home           // 师傅首页作为根目录
}

// 实名认证状态
enum CertifiStatus:Int {
    case none = 200     // 未实名
    case doing = 502    // 审核中
    case done = 501     // 已实名
    case other = 0000   // 未知
}

enum CacheType: String {
    case UserInfo = "UserInfoCache" // 用户信息
    case MasterInfo = "MasterInfoCache" // 师傅信息
    case ProfessionType = "ProfessionTypeCache" // 师傅类型
    case MerchantType = "MerchantType"  // 商家类型、经营范围
    case TaskType = "TaskTypeCache" //发布类型
}

enum GenderType: Int {
    case man = 1
    case woman = 2
    case none = 3
    
    func toString() -> String {
        switch self {
        case .man:
            return "男"
        case .woman:
            return "女"
        default:
            return "未知"
        }
    }
}
