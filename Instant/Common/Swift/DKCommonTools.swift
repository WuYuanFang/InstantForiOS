//
//  DKCommonTools.swift
//  RegionHealthForUser
//
//  Created by 吴远房 on 2018/12/3.
//  Copyright © 2018 吴远房. All rights reserved.
//

import UIKit
import Moya
import Result
import SwiftDate
import Kingfisher
import MBProgressHUD_WJExtension

class DKCommonTools: NSObject {
    
    /// 生成二维码
    class func generateQRCode(str: String) -> UIImage? {
        
        let data = str.data(using: String.Encoding.ascii)
        
        guard let filter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
        
        filter.setValue(data, forKey: "inputMessage")
        
        let transform = CGAffineTransform(scaleX: 9, y: 9)
        
        guard let output = filter.outputImage?.transformed(by: transform) else { return nil }
        
        return UIImage(ciImage: output)
    }

    
    /// 打电话
    class func callPhone(_ num:String?) -> Bool {
        guard let number = num else {
            return false
        }
        let phone = "tel://\(number)"
        if UIApplication.shared.canOpenURL(URL(string: phone)!) {
            UIApplication.shared.open(URL(string: phone)!, options: [:]) { (isOK) in
            }
            return true
        }
        return false
    }
    
    /// 长度校验
    ///
    /// - Parameter str: 校验参数
    /// - Returns: 结果
    class func verify(_ str: String?) -> Bool {
        return str != nil && str?.count ?? 0 > 0
    }
    
    /// 处理json字符串，将\r和\t去除
    ///
    /// - Parameter jsonStr: 需要处理的json字符串
    /// - Returns: 返回处理后的json字符串
    class func configJsonStr(jsonStr:String) -> String {
        var jsonString = jsonStr.replacingOccurrences(of: "\r", with: "")
        jsonString = jsonString.replacingOccurrences(of: "\t", with: "")
        return jsonString
    }
    
    /// 开启按钮倒计时
    ///
    /// - Parameter button: 当前需要倒计时的按钮
    class func openCountdown(button: UIButton){
        // 设置倒计时位60秒
        var time = 60
        // 初始化定时器
        let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        // 从60秒开始，每隔一秒开始倒计时
        codeTimer.schedule(deadline: .now(), repeating: .milliseconds(1000))  //此处方法与Swift 3.0 不同
        codeTimer.setEventHandler {
            time = time - 1
            DispatchQueue.main.async {
                button.isEnabled = false
            }
            if time <= 0 {
                // 当前时间为0时关闭倒计时，并修改按钮的样式
                codeTimer.cancel()
                DispatchQueue.main.async {
                    button.isEnabled = true
                    button.setTitle("重新发送", for: .normal)
                    button.backgroundColor = AppThemeColor
                }
                return
            }
            // 开启倒计时时，在主线程修改按钮的样式
            DispatchQueue.main.async {
                button.setTitle("发送成功\(time)", for: .normal)
                button.backgroundColor = AppCCCCCCColor
            }
        }
        // 计时器生效
        codeTimer.activate()
    }
    
    /// 通过出生日期的字符串获得年龄
    ///
    /// - Parameter birthdayStr: 出生日期的字符串
    /// - Returns: 年龄
    class func getAge(birthdayStr:String) ->Int{
        //调用方法 通过lastDate获得年龄
        let dateRi = birthdayStr.toDate()
        guard let date = dateRi?.date else {
            return 0
        }
        return calculateAge(birthday: date)
    }
    
    /// 通过出生日期获得年龄
    ///
    /// - Parameter birthday: 出生日期
    /// - Returns: 年龄
    class func calculateAge (birthday: Date) -> NSInteger {
        let nowDate = Date()
        if (nowDate.month < birthday.month) ||
            (nowDate.month == birthday.month && nowDate.day < birthday.day) {
            return nowDate.year - birthday.year - 1
        }else{
            return nowDate.year - birthday.year
        }

    }
    
    //生成一段随机的uuid
    class func getUUIDString() -> String {
        let uuidRef = CFUUIDCreate(kCFAllocatorDefault)
        let strRef = CFUUIDCreateString(kCFAllocatorDefault, uuidRef)
        let uuidString = (strRef! as String).replacingOccurrences(of: "-", with: "")
        return uuidString
    }
    
    class func getNihssGrade(_ t:String?) -> String? {
        if let grade = t {
            var nihssGrade = ""
            let gradeInt = Int(grade) ?? 0
            if gradeInt == 0 {
                nihssGrade = "\(grade)分，正常"
            }else if gradeInt == 1 {
                nihssGrade = "\(grade)分，正常或近乎正常"
            }else if gradeInt >= 2 && gradeInt <= 4 {
                nihssGrade = "\(grade)分，轻度"
            }else if gradeInt >= 5 && gradeInt <= 15 {
                nihssGrade = "\(grade)分，中度"
            }else if gradeInt >= 16 && gradeInt <= 20 {
                nihssGrade = "\(grade)分，中-重度"
            }else {
                nihssGrade = "\(grade)分，重度"
            }
            return nihssGrade
        }
        return nil
    }
    
    
    // 计算字体长度
    class func labelWidth(_ text: String, _ height: CGFloat = 15, _ fontSize: CGFloat = 16) -> CGFloat {
        let size = CGSize(width: CGFloat(MAXFLOAT), height: height)
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let labelSize = NSString(string: text).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        return labelSize.width
    }
    
    // tagconfig的配置初始化
    class func setupTagConfig(_ tagView: TTGTextTagCollectionView){
        let config: TTGTextTagConfig = tagView.defaultConfig
        config.selectedBackgroundColor = AppThemeColor
        config.minWidth = 56
        config.selectedTextColor = .white
        config.textColor = App555555Color
        config.backgroundColor = .white
        config.borderColor = App555555Color
        config.borderWidth = 0.8
        config.cornerRadius = 3.0
        config.textFont = UIFont.systemFont(ofSize: 17)
        config.shadowColor = .white
    }
    
    class func getDetailInfo() {
        ApiManagerProvider.request(.getDetailInfo) { (result) in
            if let model = UserInfoModel.mapModel(result) {
                DKUserInfo.shared.userInfo = model
                DKCacheManager.shared.setObject(model, forKey: CacheType.UserInfo.rawValue)
            }
        }
    }
    
    /// 退出登录
    class func loginOut() {
//        GPSTimerUtil.shared.cancelTimer()
        DKCacheManager.shared.removeAllObjects()
        DKUserInfo.shared.userInfo = nil
        NotificationCenter.default.post(name: .rootChangeNotifi, object: RootStatus.login)
    }
    
    
}
