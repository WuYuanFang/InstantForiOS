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
    // 获取用户详情
    case getDetailInfo
    // 保存用户信息
    case saveUserInfo(id:String?, username:String?, actualName:String?, nickname:String?, gender:String?, idCard:String?, phone:String?, headPath:String?)
}

extension ApiManager : TargetType {
    
    var baseURL: URL {
        return URL(string: "http://127.0.0.1:8090/instant")!
    }
    
    var path: String {
        switch self {
        case .uploadImg:
            return "/Upload/uplaodImg"
        case .login:
            return "/loginIn"
        case .getDetailInfo:
            return "/user/getDetailInfo"
        case .saveUserInfo:
            return "/user/updateInfo"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .saveUserInfo:
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var param: [String: String?] = [:]
        switch self {
        case .getDetailInfo:
            break
        case .uploadImg(let imgData):
            let formData = MultipartFormData(provider: .data(imgData), name: "uploadImg",
                                             fileName: "dk.png", mimeType: "image/png")
            let multipartData = [formData]
            return .uploadMultipart(multipartData)
        case .login(username: let username, password: let password):
            param = ["username":username, "password":password]
        case .saveUserInfo(id: let id,username: let username, actualName: let actualName, nickname: let nickname, gender: let gender, idCard: let idCard, phone: let phone, headPath: let headPath):
            param = ["id":id, "username":username, "actualName":actualName, "nickname":nickname, "gender":gender, "idCard":idCard, "phone":phone, "headPath":headPath]
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

