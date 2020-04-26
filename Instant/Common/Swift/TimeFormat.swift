//
//  TimeFormat.swift
//  InternetHospital
//
//  Created by apple on 2019/4/18.
//  Copyright © 2019 吴远房. All rights reserved.
//

import Foundation
import SwiftDate
import HcdDateTimePicker

enum TimeFormat: String {
    /// yyyyMMddHHmmss
    case format_yyMdHms = "yyyyMMddHHmmss"
    /// yyyyMMddHHmmssSSS
    case format_yyMdHmsSS = "yyyyMMddHHmmssSSS"
    
    /// yyyyMMdd
    case format_yyMd = "yyyyMMdd"
    /// yyyy-MM-dd
    case format_yy_M_d = "yyyy-MM-dd"
    /// yyyy-MM-dd
    case format_yy_M_d_h_m = "yyyy-MM-dd HH:mm"
    /// yyyy-MM-dd HH:mm:ss
    case format_yy_M_d_h_m_s = "yyyy-MM-dd HH:mm:ss"
}

func currentTime(to format: TimeFormat = .format_yy_M_d_h_m_s) -> String {
//    return Date().toString(.custom(format.rawValue))
    return (Date()+8.hours).toFormat(format.rawValue)
}

func timeFormatter(_ time: String? ,from: TimeFormat = .format_yyMdHmsSS, to: TimeFormat = .format_yy_M_d_h_m_s) -> String? {
    guard let tt = time else {
        return nil
    }
    guard let result = tt.toDate(style: .custom(from.rawValue))?.toString(.custom(to.rawValue)) else {
        return ""
    }
    return result
}

class TimeTool {
    static func showDatePicker(_ date:Date?, complateHandler: @escaping (_ dateStr: String?)->Void,_ mode:DatePickerMode = DatePickerDateTimeMode) {
        let pickView = HcdDateTimePickerView.init(datePickerMode: mode, defaultDateTime: date ?? Date())
        pickView?.clickedOkBtn = { datetimeStr in
            complateHandler(datetimeStr)
        }
        keyWindow?.addSubview(pickView!)
        pickView?.showHcdDateTimePicker()
    }
}
