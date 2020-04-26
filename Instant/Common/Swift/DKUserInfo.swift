//
//  DK_UserInfo.swift
//  HospitalWorkStation
//
//  Created by 吴远房 on 2019/8/13.
//  Copyright © 2019 吴远房. All rights reserved.
//

import UIKit
import HandyJSON

/// 作为用户信息持久化的key，无需硬编码
enum UserInfoKeys: String {
    case token      // 用户token
    case userId     // 用户ID
    case roleType   // 用户类型：1找师傅，2师傅
    case name      // 登录手机
}

class DKUserInfo {
    
    var animated:Bool = false
    
    var userInfo: UserInfoModel?
    
    var token: String? {
        return getString(for: .token)
    }
    var userId: String? {
        return getString(for: .userId)
    }
    var roleType: String? {
        return getString(for: .roleType)
    }
    var name: String? {
        return getString(for: .name)
    }
    var lat: Double = 23.036296
    var lon: Double = 114.419689
    
    /// 单例
    static let shared = DKUserInfo()
    private init() {}
    
}


/// 实现 UserDefaultsSettable 协议，从而无需硬编码 key 来保存数据
extension DKUserInfo: UserDefaultsSettable {
    typealias userDefaultsKeys = UserInfoKeys
    
    func updateToken(token: String) {
        set(token, forKey: .token)
    }
    
    func updateUserId(userId: String) {
        set(userId, forKey: .userId)
    }
    
    func updateRoleType(usertype: String) {
        set(usertype, forKey: .roleType)
    }
    
    func updateName(phone: String) {
        set(phone, forKey: .name)
    }
    
    func removeAll() {
        removeObject(key: .token)
        removeObject(key: .userId)
    }
}

