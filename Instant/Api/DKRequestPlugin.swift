//
//  DKRequestPlugin.swift
//  CattleMaster
//
//  Created by yuanfang wu on 2020/2/14.
//  Copyright © 2020 CattleMaster. All rights reserved.
//

import UIKit
import Moya
import Result

/// Moya接口请求的插件
class DKRequestPlugin: PluginType {
    /// 接口请求回调后会调用此方法
    ///
    /// - Parameters:
    ///   - result: 接口请求返回的参数
    ///   - target: 接口请求的TargetType
    func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            let jsonStr = String.init(data: response.data, encoding: .utf8)
//            let codeStr = (target.baseURL.absoluteString + target.path).replacingOccurrences(of: "/", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ":", with: "")
            print("请求地址：\(target.path)\n请求成功,返回的参数==>", jsonStr ?? "")
        case let .failure(error):
            print("请求地址：\(target.path)\n请求失败", error)
        }
    }
    
    
    /// 接口请求前会调用此方法
    ///
    /// - Parameters:
    ///   - request: 接口请求的地址，方法等
    ///   - target: 接口请求TargetType
    func willSend(_ request: RequestType, target: TargetType) {
        
        print("请求的链接==>", request)
        switch target.task {
        case let Task.requestParameters(parameters, _):
            print("请求的参数==>", parameters)
        default:
            break
        }
    }
}




