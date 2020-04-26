//
//  UserDefaultSettable.swift
//  InternetHospital
//
//  Created by apple on 2019/5/10.
//  Copyright © 2019 吴远房. All rights reserved.
//

import Foundation

/// # UserDefaults 协议，提供默认实现
///
/// _通过字符串枚举 set/get key 的对应值，无需硬编码 key_
/// ## 如何使用：
/// 1. 自定义 RawRepresentable 类型如 Enum，RawValue 必须是字符串
/// 2. 设置需要使用的类型符合 UserDefaultsSettable 协议
/// 3. 设置关联类型 userDefaultsKeys 为自定义类型
/// 4. 使用 set/get 协议方法
protocol UserDefaultsSettable {
    associatedtype userDefaultsKeys: RawRepresentable
}

extension UserDefaultsSettable where userDefaultsKeys.RawValue == String {
    func set(_ value: Any?, forKey key: userDefaultsKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    func set(_ value: Bool, forKey key: userDefaultsKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    func set(_ value: Int, forKey key: userDefaultsKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    func set(_ value: Float, forKey key: userDefaultsKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    func set(_ value: Double, forKey key: userDefaultsKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func getInt(for key: userDefaultsKeys) -> Int {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    func getBool(for key: userDefaultsKeys) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    func getFloat(for key: userDefaultsKeys) -> Float {
        return UserDefaults.standard.float(forKey: key.rawValue)
    }
    func getDouble(for key: userDefaultsKeys) -> Double {
        return UserDefaults.standard.double(forKey: key.rawValue)
    }
    func getString(for key: userDefaultsKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    func getObject(for key: userDefaultsKeys) -> Any? {
        return UserDefaults.standard.object(forKey: key.rawValue)
    }
    
    func removeObject(key: userDefaultsKeys) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
