//
//  FoundationExtension.swift
//  CattleMaster
//
//  Created by yuanfang wu on 2020/3/20.
//  Copyright © 2020 CattleMaster. All rights reserved.
//

import Foundation
import CommonCrypto.CommonDigest

extension Int{
    
    func toString() -> String {
        return String(format: "%.2lf", Double(self) / 100)
    }
    
    func toDouble() -> Double {
        return Double(self) / 100
    }
}
extension String {
    
    /// 当前字符串是否只包含空白字符和换行符
    func isWhitespaceAndNewlines() -> Bool {
        for char in self {
            if !char.isWhitespace && !char.isNewline {
                return false
            }
        }
        return true
    }
    
    /// MD5 大写
    func md5Upper() -> String {
        let cStr = cString(using: .utf8)
        let cStrLen = CC_LONG(lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(cStr, cStrLen, result)
        
        var hash = String()
        for i in 0 ..< digestLen {
            hash.append(String(format: "%02X", result[i]))
        }
        
        result.deallocate()
        
        return hash
    }
    
    /// MD5 小写
    func md5Lower() -> String {
        let cStr = cString(using: .utf8)
        let cStrLen = CC_LONG(lengthOfBytes(using: .utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(cStr, cStrLen, result)
        
        var hash = String()
        for i in 0 ..< digestLen {
            hash.append(String(format: "%02x", result[i]))
        }
        
        result.deallocate()
        
        return hash
    }
    
    func toRange(_ range: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: range.location, limitedBy: utf16.endIndex) else { return nil }
        guard let to16 = utf16.index(from16, offsetBy: range.length, limitedBy: utf16.endIndex) else { return nil }
        guard let from = String.Index(from16, within: self) else { return nil }
        guard let to = String.Index(to16, within: self) else { return nil }
        return from ..< to
    }
    
}

extension Double {
    func decimal2() -> String {
        return String(format: "%.2f", self)
    }
}

extension UIWindow {
    static func visibleWindow() -> UIWindow? {
        var currentWindow = UIApplication.shared.keyWindow
        
        if currentWindow == nil {
            let frontToBackWindows = Array(UIApplication.shared.windows.reversed())
            
            for window in frontToBackWindows {
                if window.windowLevel == UIWindow.Level.normal {
                    currentWindow = window
                    break
                }
            }
        }
        
        return currentWindow
    }
}
