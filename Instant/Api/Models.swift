//
//  Models.swift
//  CattleMaster
//
//  Created by yuanfang wu on 2020/2/14.
//  Copyright © 2020 CattleMaster. All rights reserved.
//

import UIKit
import HandyJSON

/// 给外部使用无需 import HandyJSON
typealias ExtensionJSON = HandyJSON

/// 公共返回model
struct DataModel<T> : HandyJSON {
    var code: Int = 200
    var msg: String = ""
    var time: String = ""
    var success: Bool = false
    var data : T?
}

struct DataList<T> : HandyJSON {
    var page: Int = 1
    var count : Int = 0
    var list : [T] = []
}

/// data 字段为 null 类型 或者忽略 data 数据
struct ResultData : HandyJSON {}

/// data是string的model
struct StringModel : HandyJSON {
    
}
struct LoginResultModel : HandyJSON {
    var id: String?
    var username: String?
    var nickname: String?
    var password: String?
    var actualName: String?
    var idCard: String?
    var gender: Int = 1 // 1.男、2.女、3.未知
    var phone: String?
    var headPath: String?
    var isDelete: String?
    var createUser: String?
    var createTime: String?
    var lastUpdateUser: String?
    var lastUpdateTime: String?
    var token: String?
}

struct UserInfoModel: HandyJSON, Codable {
    var id: String?
    var username: String?
    var nickname: String?
    var password: String?
    var actualName: String?
    var idCard: String?
    var gender: Int = 1 // 1.男、2.女、3.未知
    var phone: String?
    var headPath: String?
    var isDelete: String?
    var createUser: String?
    var createTime: String?
    var lastUpdateUser: String?
    var lastUpdateTime: String?
}
