//
//  DKButtonExtension.swift
//  CattleMaster
//
//  Created by wuyuanfang on 2019/11/25.
//  Copyright © 2019 CattleMaster. All rights reserved.
//

import UIKit

extension UIButton {

    func imgLabelCenter() {
        self.contentHorizontalAlignment = .center
        self.titleEdgeInsets = UIEdgeInsets(top: self.imageView?.frame.size.height ?? 0, left: -(self.imageView?.frame.size.width ?? 0), bottom: 0, right: 0)
        self.imageEdgeInsets = UIEdgeInsets(top: -(self.imageView?.frame.size.height ?? 0), left: 0, bottom: 0, right: -(self.titleLabel?.frame.size.width ?? 0))
    }

}
