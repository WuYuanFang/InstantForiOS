//
//  DKWXApiManager.swift
//  CattleMaster
//
//  Created by yuanfang wu on 2020/2/27.
//  Copyright © 2020 CattleMaster. All rights reserved.
//

import UIKit
import MBProgressHUD_WJExtension

protocol DKWXApiManagerDelegate {
    func onResponse(_ result:Bool,_ msg:String?,_ openid:String?,_ token:String?)
}

class DKWXApiManager: NSObject {
    
    var type:String = "1" // 登录类型：1找师傅、2师傅
    private let AppID = "wx52fa4bbfd26467df"
    private let AppSecret = "42929f956deb716f031d4c7df7401533"
    
    /// 单例
    static let shared = DKWXApiManager()
    private override init() {
    }
    
    var delegate: DKWXApiManagerDelegate?
    
    func pay(_ model:PayReq) {
        WXApi.send(model) { (res) in
            print("返回-->\(res)")
        }
    }
    
    // 微信分享
    func share(_ msg:WXMediaMessage,_ url:String) {
        /**
                    WXWebpageObject *webpageObject = [WXWebpageObject object];
                    webpageObject.webpageUrl = @"https://open.weixin.qq.com";
                    WXMediaMessage *message = [WXMediaMessage message];
                    message.title = @"标题";
                    message.description = @"描述";
                    [message setThumbImage:[UIImage imageNamed:@"缩略图.jpg"]];
                    message.mediaObject = webpageObject;
                    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
                    req.bText = NO;
                    req.message = message;
                    req.scene = WXSceneSession;
                    [WXApi sendReq:req];
         */
        let webpageObject = WXWebpageObject()
        webpageObject.webpageUrl = url
        msg.mediaObject = webpageObject
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = msg
        req.scene = Int32(WXSceneSession.rawValue)
        WXApi.send(req) { (bool) in
            print("微信分享发送成功")
        }
        
    }
    
}

extension DKWXApiManager : WXApiDelegate {
    
    func onResp(_ resp: BaseResp) {
        if resp is PayResp {
            // 微信支付
            switch resp.errCode {
            case WXSuccess.rawValue:
                print("微信支付成功")
                self.delegate?.onResponse(true, "微信支付成功", nil, nil)
            case WXErrCodeUserCancel.rawValue:
                self.delegate?.onResponse(false, "用户关闭微信支付", nil, nil)
                print("用户关闭微信支付")
            default:
                self.delegate?.onResponse(false, resp.errStr, nil, nil)
                print("微信支付错误信息:----->\(resp.errCode)---->\(resp.errStr)")
            }
        }else if resp is SendAuthResp {
            // 微信登录
            print("微信----登录")
            switch resp.errCode {
            case WXSuccess.rawValue:
                if let res = resp as? SendAuthResp, res.code?.count ?? 0 > 0 {
                    self.loginSuccessByCode(code: res.code!)
                }
            case WXErrCodeUserCancel.rawValue:
                print("用户关闭微信支付")
            case WXErrCodeAuthDeny.rawValue:
                MBProgressHUD.wj_showError("微信授权失败")
            default:
                MBProgressHUD.wj_showError("微信登录失败")
            }
        }else if resp is SendMessageToWXResp {
            // 微信分享
            if resp.errCode == WXSuccess.rawValue {
                MBProgressHUD.wj_showSuccess("微信分享成功")
            }else{
                MBProgressHUD.wj_showError("微信分享失败")
            }
        }
    }
    
    func onReq(_ req: BaseReq) {
        
    }
    
}

//MARK: 请求扩展
extension DKWXApiManager {
    
    //MARK: ==================== 微信授权回调
    func loginSuccessByCode(code: String) {
        let urlString = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(AppID)&secret=\(AppSecret)&code=\(code)&grant_type=authorization_code"
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if error == nil && data != nil {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                        let access_token = dic["access_token"] as! String
                        let openID = dic["openid"] as! String
                        self.delegate?.onResponse(true, "成功", openID, access_token)
                        //                        self.requestUserInfo(access_token, openID)
                    } catch  {
                        print(#function)
                    }
                    return
                }
            })
        }.resume()
    }
    
    //MARK: ==================== 获取用户个人信息（UnionID机制）
    func requestUserInfo(_ token: String, _ openID: String) {
        let urlString = "https://api.weixin.qq.com/sns/userinfo?access_token=\(token)&openid=\(openID)"
        
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async(execute: {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                if error == nil && data != nil {
                    do {
                        let dic = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                        //dic当中包含了微信登录的个人信息，用于用户创建、登录、绑定等使用
                        print(#line, dic)
                    } catch  {
                        print(#function)
                    }
                    return
                }
            })
        }.resume()
    }
    
}
