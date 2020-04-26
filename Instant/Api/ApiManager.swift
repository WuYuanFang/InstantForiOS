//
//  ApiManager.swift
//  CattleMaster
//
//  Created by yuanfang wu on 2020/2/14.
//  Copyright © 2020 CattleMaster. All rights reserved.
//

import UIKit
import Moya

let requestPlugin = DKRequestPlugin()
// 有日志请求
let ApiManagerProvider = MoyaProvider<ApiManager>(plugins: [requestPlugin])
// 无日志请求
let ApiNoLogManagerProvider = MoyaProvider<ApiManager>()


enum ApiManager {
    // 上传图片
    case uploadImg(imgData:Data)
    // 登录
    case login(username:String?, password:String?)
}

extension ApiManager : TargetType {
    
    var baseURL: URL {
        return URL(string: "https://shengwwl.com")!
    }
    
    var path: String {
        switch self {
        case .uploadImg:
            return "/Upload/uplaodImg"
        case .login:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login:
            return .post
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var param: [String: String?] = [:]
        switch self {
        case .uploadImg(let imgData):
            let formData = MultipartFormData(provider: .data(imgData), name: "uploadImg",
                                             fileName: "dk.png", mimeType: "image/png")
            let multipartData = [formData]
            return .uploadMultipart(multipartData)
        case .login(username: let username, password: let password):
            param = ["username":username, "password":password]
        }
        // 在此处添加公共参数
        // 将参数中value为nil的过滤掉
        let newParam = filterParamRemoveNil(param)
        return .requestParameters(parameters: newParam, encoding: URLEncoding.queryString)
    }
    
    var headers: [String : String]? {
        switch self {
        case .uploadImg:
            return ["Content-Type":"multipart/form-data;","token":DKUserInfo.shared.token ?? ""]
        case .login:
            return nil
        default:
            return ["token":DKUserInfo.shared.token ?? ""]
        }
    }
}

//MARK: Apimanager-----
extension ApiManager {
    
    // 拼接地址
    static func fullPath(_ path:String) -> String {
        return "https://shengwwl.com/\(path)"
    }
    
    // 处理字典，将nil的数据不添加到参数里面
    func filterParamRemoveNil(_ param:[String:String?]) -> [String:String] {
        var newParam:[String:String] = [:]
        for dic in param {
            if let val = dic.value {
                newParam[dic.key] = val
            }
        }
        return newParam
    }
}

