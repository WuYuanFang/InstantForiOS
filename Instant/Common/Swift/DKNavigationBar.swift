//
//  DKNavigationBar.swift
//  CattleMaster
//
//  Created by wuyuanfang on 2019/11/26.
//  Copyright © 2019 CattleMaster. All rights reserved.
//

import UIKit

class DKNavigationBar: UIView {
    var titleStr : String?
    var leftItems, rightItems : Array<DKBarItem>?
    
    lazy var leftView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var rightView : UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    func setupView (){
        self.addSubview(self.leftView)
        self.leftView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(StatusBarHeight)
            make.bottom.equalToSuperview()
            make.width.equalTo(0)
        }
        
        self.addSubview(self.rightView)
        self.rightView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().offset(StatusBarHeight)
            make.bottom.equalToSuperview()
            make.width.equalTo(0)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.leftView).offset(8)
            make.right.equalTo(self.rightView).offset(-8)
            make.top.equalToSuperview().offset(StatusBarHeight)
            make.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleLabel.text = self.titleStr ?? ""
        _ = self.leftView.subviews.map {
            $0.removeFromSuperview()
        }
        _ = self.rightView.subviews.map {
            $0.removeFromSuperview()
        }
        if let items = self.leftItems {
            for (i, it) in items.enumerated() {
                let btn:DKButton = self.createBtn(item: it, index: i)
                btn.item = it
                self.leftView.addSubview(btn)
                self.leftView.snp.updateConstraints { (make) in
                    make.width.equalTo(44*self.leftItems!.count)
                }
            }
        }
        if let items = self.rightItems {
            for (i, it) in items.enumerated() {
                let btn:DKButton = self.createBtn(item: it, index: i)
                btn.item = it
                self.rightView.addSubview(btn)
                self.rightView.snp.updateConstraints { (make) in
                    make.width.equalTo(44*self.rightItems!.count)
                }
            }
        }
    }
    
    func createBtn(item : DKBarItem, index : Int) -> DKButton{
        let btn = DKButton.init(frame: CGRect.init(x: index*44, y: 0, width: 44, height: 44))
        btn.addTarget(self, action: #selector(btnPress(sender:)), for: UIControl.Event.touchUpInside)
        if item.itemStyle == 0{
            btn.setTitle(item.itemTitle, for: UIControl.State.normal)
            btn.setTitleColor(item.titleColor, for: UIControl.State.normal)
        }else {
            btn.setImage(UIImage.init(named: item.itemImg ?? ""), for: UIControl.State.normal)
        }
        return btn
    }
    
    @objc func btnPress(sender : DKButton){
        let item:DKBarItem = sender.item ?? DKBarItem.init()
        item.barItemClick!(item)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

class DKButton : UIButton{
    var userInfo : Any?
    var item : DKBarItem?
    
    typealias ButtonOnClick = ()->Void
    var buttonOnClick : ButtonOnClick?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DKBarItem : NSObject{
    var itemStyle : Int? ////样式：0文字/1图片/2文字+图片(样式指定)
    var itemTitle : String?
    var itemImg : String?
    var imgSize : CGSize?
    var titleColor : UIColor?
    
    typealias BarItemClick = (_ item : DKBarItem)->Void
    var barItemClick : BarItemClick?
    
    class func setupItemWithTitle(title : String, click : @escaping BarItemClick) -> DKBarItem{
        let item = DKBarItem.init()
        item.itemStyle = 0
        item.itemTitle = title
        item.barItemClick = click
        return item
    }
    
    class func setupItemWithImage(img : String, click : @escaping BarItemClick) -> DKBarItem{
        let item = DKBarItem.init()
        item.itemStyle = 1
        item.itemImg = img
        item.barItemClick = click
        return item
    }
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

