//
//  UIColorTools.swift
//  HospitalWorkStation
//
//  Created by 吴远房 on 2019/8/13.
//  Copyright © 2019 吴远房. All rights reserved.
//
// 颜色工具类
import UIKit

extension UIColor {
    
    /// 通过16进制的数字转成颜色
    ///
    /// - Parameter rgb16Str: 16进制的数字 如：0xffffff
    /// - Returns: 返回颜色UIColor
    class func colorWitHex(rgb16Str:Int) -> UIColor {
        return self.colorWitHex(rgb16Str: rgb16Str, alpha: 1.0)
    }
    
    /// 通过16进制的数字转成颜色
    ///
    /// - Parameters:
    ///   - rgb16Str: 16进制的数字 如：0xffffff
    ///   - alpha: 透明度 如：1.0
    /// - Returns: 返回颜色UIColor
    class func colorWitHex(rgb16Str:Int, alpha:CGFloat) -> UIColor {
        return UIColor(red: ((CGFloat)((rgb16Str & 0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb16Str & 0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb16Str & 0xFF)) / 255.0,
                       alpha: 1.0)
        
    }
}

