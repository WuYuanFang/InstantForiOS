//
//  ModelsMapper.swift
//  InternetHospital
//
//  Created by apple on 2019/5/16.
//  Copyright © 2019 吴远房. All rights reserved.
//

import Foundation
import Moya
import Result
import HandyJSON
import MBProgressHUD_WJExtension

enum ModelResult<T> {
    case success(msg: String, data: T?)
    case failure(errMsg: String)
}

extension HandyJSON {
    
    // 单个模型，返回的成功时data为nil或者字符串，直接回调
    static func mapSuccess(_ result: Result<Response, MoyaError>, toast: Bool = false,_ showError:Bool = true) -> String? {
        let model = mapModelResult(result)
        switch model {
        case let .success(msg, _):
            if toast { MBProgressHUD.wj_showSuccess(msg) }
            return "200"
        case let .failure(errMsg):
            if showError {
                MBProgressHUD.wj_showError(errMsg)
            }
            return nil
        }
    }
    
    /// 单个模型映射，返回 Model 或 nil
    static func mapModel(_ result: Result<Response, MoyaError>, toast: Bool = false,_ showError:Bool = true) -> Self? {
        let model = mapModelResult(result)
        switch model {
        case let .success(msg, data):
            if toast { MBProgressHUD.wj_showSuccess(msg) }
            return data
        case let .failure(errMsg):
            if showError {MBProgressHUD.wj_showError(errMsg)}
            return nil
        }
    }
    
    /// 模型数组映射，返回 [Model] 或 nil
    static func mapModelArray(_ result: Result<Response, MoyaError>, toast: Bool = false) -> [Self]? {
        let model = mapModelArrayResult(result)
        switch model {
        case let .success(msg, data):
            if toast { MBProgressHUD.wj_showSuccess(msg) }
            return data
        case let .failure(errMsg):
            if toast { MBProgressHUD.wj_showError(errMsg)}
            print("请求获取数据失败")
            return nil
        }
    }
    
    /// 将请求结果映射为 ModelResult 类型， data 为模型
    static func mapModelResult(_ result: Result<Response, MoyaError>) -> ModelResult<Self> {
        switch result {
        case .success(let response):
            
            let json = try? response.mapString()
            
            guard let info = ResponseInfo.deserialize(from: json) else {
                return .failure(errMsg: "数据解析错误")
            }
            guard info.code == 0000 || info.code == 200 else{
                return .failure(errMsg: info.msg ?? "")
            }
            
            let data = Self.deserialize(from: json, designatedPath: "data")
            return .success(msg: info.msg ?? "", data: data)
            
        case .failure(let error):
            let msg = error.errorDescription ?? ""
            return .failure(errMsg: msg)
        }
    }
    
    /// 将请求结果映射为 ModelResult 类型，data 为模型数组
    static func mapModelArrayResult(_ result: Result<Response, MoyaError>) -> ModelResult<[Self]> {
        switch result {
        case .success(let response):
            
            let json = try? response.mapString()
            
            guard let info = ResponseInfo.deserialize(from: json) else {
                return .failure(errMsg: "数据解析错误")
            }
            guard info.code == 0000 || info.code == 200 else{
//                // 用户未登录（离线）
//                if info.code == 402 {
//                    DK_UserInfo.didChange(loginStatus: .failure)
//                }
                return .failure(errMsg: info.msg ?? "")
            }
            
            let data = [Self].deserialize(from: json, designatedPath: "data")?.compactMap({ $0 })
            return .success(msg: info.msg ?? "", data: data)
            
        case .failure(let error):
            let msg = error.errorDescription ?? ""
            return .failure(errMsg: msg)
        }
    }
    
    
    /// 单个JSON对象映射，返回 Model 或 nil
    static func mapJSON(_ json:String?) -> Self? {
        let model = mapStringResult(json)
        switch model {
        case let .success(_, data):
            return data
        case .failure(_):
            return nil
        }
    }
    /// 将请求结果映射为 ModelResult 类型， data 为模型
    static func mapStringResult(_ json:String?) -> ModelResult<Self> {
        guard let info = ResponseInfo.deserialize(from: json) else {
            return .failure(errMsg: "数据解析错误")
        }
        guard info.code == 0000 else{
            return .failure(errMsg: info.msg ?? "")
        }
        let data = Self.deserialize(from: json, designatedPath: "data")
        return .success(msg: info.msg ?? "", data: data)
    }
    
    /// data里面只是string
    static func mapString(_ result: Result<Response, MoyaError>) -> String? {
        switch result {
        case .success(let response):
            let json = try? response.mapString()
            guard let info = ResponseInfo.deserialize(from: json) else {
                MBProgressHUD.wj_showError("数据错误")
                return nil
            }
            guard info.code == 0000 || info.code == 200 else{
                MBProgressHUD.wj_showError(info.msg ?? "")
                return nil
            }
            
            let dataStr = DataModel<String>.deserialize(from: json)?.data ?? ""
            return dataStr
        case .failure(let error):
            let msg = error.errorDescription ?? ""
            MBProgressHUD.wj_showError(msg)
            return nil
        }
    }

}
