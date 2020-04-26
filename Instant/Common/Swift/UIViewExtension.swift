//
//  UIView+Extension.swift
//  RegionHealthForUser
//
//  Created by 吴远房 on 2018/11/14.
//  Copyright © 2018 吴远房. All rights reserved.
//

import UIKit

/// MARK - UIView
extension UIView {
    
    // MARK: - 常用位置属性
    public var left:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    
    public var top:CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(newTop) {
            var frame = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    
    public var height:CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    
    public var right:CGFloat {
        get {
            return self.left + self.width
        }
    }
    
    public var bottom:CGFloat {
        get {
            return self.top + self.height
        }
    }
    
    public var centerX:CGFloat {
        get {
            return self.center.x
        }
        
        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
    
    func removeAllSubviews(){
        while self.subviews.count > 0 {
            let child = self.subviews.last
            child?.removeFromSuperview()
        }
    }
    
    class func alertMessage(message:String) {
        self.alertTitle(title: "提示", message: message, confirm: "确定", cancel: "", confirmHander: { () in
            
            })
    }
    
    class func alertMessage(message:String, corfirmHeander: @escaping ()-> Void) {
        self.alertTitle(title: "提示", message: message, confirm: "确定", cancel: "取消", confirmHander: corfirmHeander)
    }
    
    class func alertTitle(title:String, message:String, confirm:String, cancel:String, confirmHander: @escaping ()->Void) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if cancel.count > 0{
            alertVC.addAction(UIAlertAction.init(title: cancel, style: UIAlertAction.Style.cancel, handler: nil))
        }
        alertVC.addAction(UIAlertAction.init(title: confirm, style: UIAlertAction.Style.default, handler: { (action) in
            confirmHander()
        }))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
    
    class func actionSheet(title:String, _ message:String?, actions:[String], confirmHander: @escaping (_ actionStr:String, _ indexP:Int)->Void) {
        let alertVC = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        for index in 0..<actions.count {
            let actionName = actions[index]
            alertVC.addAction(UIAlertAction.init(title: actionName, style: .default, handler: { (action) in
                confirmHander(actionName, index)
            }))
        }
        alertVC.addAction(UIAlertAction.init(title: "取消", style: .cancel, handler: nil))
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: nil)
        
    }
    
    class func alertTextView(title:String,_ textView:UITextView, confirm:String, cancel:String, confirmHandle: @escaping(_ textStr:String) -> Void) {
        let alertVC = UIAlertController.init(title: "\(title)\n\n\n\n\n\n\n", message: "\n\n", preferredStyle: .alert)
        textView.frame = CGRect(x: 15, y: 60, width: 240, height: 160)
        textView.layer.borderColor = AppCCCCCCColor.cgColor
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.borderWidth = 1.0
        textView.layer.cornerRadius = 5.0
        textView.returnKeyType = .done
        alertVC.view.addSubview(textView)
        let cancelAction = UIAlertAction.init(title: cancel, style: .cancel, handler: nil)
        let okAction = UIAlertAction.init(title: confirm, style: .default, handler: { (action) in
            confirmHandle(textView.text)
        })
        alertVC.addAction(cancelAction)
        alertVC.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertVC, animated: true, completion: nil)
    }
    
    /// 设置视图阴影
    /// - Parameters:
    ///   - view: 需要设置的视图
    ///   - cradius: 需要设置的圆角
    ///   - sColor: 阴影的颜色
    ///   - offset: 偏移量
    ///   - opacity: 透明度
    ///   - radius: 阴影半径
    func setShadow(cradius:CGFloat,sColor:UIColor,offset:CGSize,
                   opacity:Float,radius:CGFloat) {
        //设置阴影颜色
        self.layer.shadowColor = sColor.cgColor
        //设置边框圆角
        self.layer.cornerRadius = cradius
        //设置透明度
        self.layer.shadowOpacity = opacity
        //设置阴影半径
        self.layer.shadowRadius = radius
        //设置阴影偏移量
        self.layer.shadowOffset = offset
    }
    
    /// 创建下划线
    ///
    /// - Returns: 返回初始化的控件
    class func createLine(_ topV:UIView, _ superView:UIView,_ topHei:CGFloat = 0.0, _ sameBg:Bool = true) -> UIView {
        let v = UIView()
        v.backgroundColor = UIColor.colorWitHex(rgb16Str: 0xf1f1f1)
        superView.addSubview(v)
        v.snp.makeConstraints { (make) in
            if sameBg {
                make.left.right.equalToSuperview()
            }else{
                make.left.right.equalTo(topV)
            }
            make.top.equalTo(topV.snp.bottom).offset(topHei)
            make.height.equalTo(1.0)
        }
        return v
    }
    
}

