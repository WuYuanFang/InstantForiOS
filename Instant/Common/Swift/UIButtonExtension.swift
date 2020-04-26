//
//  UIButtonExtension.swift
//  CattleMaster
//
//  Created by wuyuanfang on 2019/11/27.
//  Copyright © 2019 CattleMaster. All rights reserved.
//

import UIKit

extension UIButton {

    class func createBtn(_ title:String, _ bgColor:UIColor = AppThemeYellowColor, _ cRadius:CGFloat = 20.0) -> UIButton {
        let btn = UIButton()
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle(title, for: .normal)
        btn.layer.cornerRadius = cRadius
        btn.backgroundColor = bgColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return btn
    }

}
