//
//  ResponseInfo.swift
//  CattleMaster
//
//  Created by wuyuanfang on 2019/11/22.
//  Copyright © 2019 CattleMaster. All rights reserved.
//

import UIKit
import HandyJSON

// MARK: - 数据模型
/// 响应信息
struct ResponseInfo: HandyJSON {
    var code: Int = 0
    var msg: String?
}

// textfieldCell的界面的数据展示和存储的Model
struct TextFieldModel: HandyJSON {
    var leftStr: String = ""
    var placeHolderStr: String = ""
    var rightStr: String = ""
    var data: Any?
    var index: Int = 0
}
