//
//  FoundationExtension.swift
//  CattleMaster
//
//  Created by yuanfang wu on 2020/3/20.
//  Copyright © 2020 CattleMaster. All rights reserved.
//

import UIKit

extension Int{

    func toString() -> String {
        return String(format: "%.2lf", Double(self) / 100)
    }
    
    func toDouble() -> Double {
        return Double(self) / 100
    }

}
