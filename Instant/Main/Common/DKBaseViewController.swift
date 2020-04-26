//
//  DKBaseViewController.swift
//  CattleMaster
//
//  Created by wuyuanfang on 2019/11/22.
//  Copyright © 2019 CattleMaster. All rights reserved.
//

import UIKit

class DKBaseViewController: UIViewController {
    
    typealias NormalBlock = ()->Void
    
    var normalBlock:NormalBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
    }
    
}
