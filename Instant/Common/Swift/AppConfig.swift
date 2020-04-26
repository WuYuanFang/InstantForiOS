//
//  AppConfig.swift
//  RegionHealthForUser
//
//  Created by 吴远房 on 2018/11/14.
//  Copyright © 2018 吴远房. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

let DEBUG_MODE = true //debug模式，（是否打印日志）

let keyWindow = UIApplication.shared.keyWindow
//MARK:------- 屏幕尺寸 --------
// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
//顶部状态栏高度
let StatusBarHeight = UIApplication.shared.statusBarFrame.size.height
//底部安全区域
let FootSafeHeight = CGFloat((UIApplication.shared.statusBarFrame.size.height>20) ? 34.0 : 0.0)
//导航栏高度
let NavBarHeight:CGFloat = 44
//导航栏+状态栏高度
let TopSafeHeight = UIApplication.shared.statusBarFrame.size.height+44.0
//底部Tab高度
let TabBarHeight:CGFloat = 49
// 保存按钮的宽度
let SaveBtnWidth:CGFloat = 280

//MARK:------ 颜色 -------
let AppThemeYellowColor = UIColor.init(red: 255/255.0, green: 122/255.0, blue: 0/255.0, alpha: 1.0)
let AppBlueColor = UIColor.init(red: 93/255.0, green: 174/255.0, blue: 253/255.0, alpha: 1.0)
let AppRedColor = UIColor.init(red: 252/255.0, green: 101/255.0, blue: 106/255.0, alpha: 1.0)
let AppGreenColor = UIColor.init(red: 37/255.0, green: 155/255.0, blue: 36/255.0, alpha: 1.0)
let AppBGColor = UIColor.init(red: 250/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1.0)//背景色
let App333333CGolor = UIColor.init(red: 51/255.0, green: 51/255.0, blue: 51/255.0, alpha: 1.0) //#333333 深灰色
let App555555Color = UIColor.init(red: 85/255.0, green: 85/255.0, blue: 85/255.0, alpha: 1.0) //#555555 灰色
let App999999Color = UIColor.init(red: 153/255.0, green: 153/255.0, blue: 153/255.0, alpha: 1.0) //#999999 中灰色
let AppCCCCCCColor = UIColor.init(red: 204/255.0, green: 204/255.0, blue: 204/255.0, alpha: 1.0) //#CCCCCC 浅灰色
let AppF0F0F0Color = UIColor.init(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1.0)

//MARK:------ 枚举 ------
