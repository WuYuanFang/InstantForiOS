//
//  UITextFieldExtension.swift
//  HospitalWorkStation
//
//  Created by 吴远房 on 2019/8/20.
//  Copyright © 2019 吴远房. All rights reserved.
//

import UIKit

extension UITextField {
    
    // 创建textField：左边是label，右边是textField
    class func createField(_ leftS:String,_ placeStr:String="请选择",_ showImg:Bool=false,_ righgImg:Bool=false, _ leftWid:CGFloat = (UIScreen.main.bounds.size.width-16)/2-20) -> UITextField {
        
        var leftWidth = leftWid-8
        if DKCommonTools.labelWidth(leftS, 48) < leftWidth {
            leftWidth = DKCommonTools.labelWidth(leftS, 48)
        }
        
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: leftWid, height: 48))
        leftView.clipsToBounds = true
        if showImg {
            let leftImg = UIImageView.init(frame: CGRect(x: 0, y: 20, width: 8, height: 8))
            leftImg.image = UIImage.init(named: "icon_start")
            leftImg.contentMode = .scaleAspectFit
            leftView.addSubview(leftImg)
        }
        let leftLabel = UILabel.init(frame: CGRect(x: showImg ? 10 : 0, y: 0, width: leftWidth, height: 48))
        leftLabel.text = leftS
        leftLabel.numberOfLines = 0
        leftLabel.font = UIFont.systemFont(ofSize: 16)
        leftLabel.textColor = App333333CGolor
        leftView.addSubview(leftLabel)
        
        let textField = UITextField()
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = leftView
        textField.placeholder = placeStr
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 16)
        
        if righgImg {
            let rightView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 24, height: 48))
            rightView.clipsToBounds = true
            let rImg = UIImageView.init(frame: CGRect(x: 5, y: 17, width: 14, height: 14))
            rImg.image = UIImage.init(named: "icon_rightarrow")
            rImg.contentMode = .scaleAspectFit
            rightView.addSubview(rImg)
            textField.rightView = rightView
            textField.rightViewMode = .always
        }
        return textField
    }
    
    class func  createInputField(_ imgStr:String, _ placeHolder:String = "请输入", _ isShowLine:Bool = true) -> UITextField {
        
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 48, height: 48))
        leftView.clipsToBounds = true
        let leftImg = UIImageView.init(frame: CGRect(x: 12, y: 12, width: 24, height: 24))
        leftImg.image = UIImage.init(named: imgStr)
        leftImg.contentMode = .scaleAspectFit
        leftView.addSubview(leftImg)
        
        let textField = UITextField()
        textField.clipsToBounds = true
        textField.leftViewMode = .always
        textField.leftView = leftView
        textField.placeholder = placeHolder
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }
    
    static func createSelectField(_ placeStr:String="请选择", _ imgWid:CGFloat = 8) -> UITextField {
        let leftView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 24, height: 44))
        leftView.clipsToBounds = true
        let leftImg = UIImageView.init(frame: CGRect(x: 0, y: 0, width: imgWid, height: 44))
        leftImg.image = UIImage.init(named: "icon_downpull")
        leftImg.contentMode = .scaleAspectFit
        leftView.addSubview(leftImg)
        
        let textField = UITextField()
        textField.clipsToBounds = true
        textField.rightViewMode = .always
        textField.rightView = leftView
        textField.placeholder = placeStr
        textField.textAlignment = .center
        textField.font = UIFont.systemFont(ofSize: 16)
        return textField
    }
    
}
