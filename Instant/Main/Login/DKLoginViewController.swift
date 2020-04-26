//
//  DKLoginViewController.swift
//  Instant
//
//  Created by yuanfang wu on 2020/4/26.
//  Copyright © 2020 yuanfang wu. All rights reserved.
//

import UIKit
import MBProgressHUD_WJExtension

class DKLoginViewController: DKBaseViewController {

    var selectBtn: UIButton?
    var nameField, pwdField: UITextField!
    var wecharBtn:UIButton!
    var linemsg:UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "登录"
        setupUI()
    }
    
    func setupUI() {
        nameField = UITextField.createInputField("icon_login_name", "请输入用户名", true)
        nameField.keyboardType = .numberPad
        nameField.delegate = self
        nameField.text = DKUserInfo.shared.name ?? "admin"
        nameField.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(nameField)
        nameField.snp.makeConstraints({ (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.centerY.equalTo(self.view).offset(-TopSafeHeight-30)
            make.height.equalTo(40)
        })
        let line = UIView()
        line.backgroundColor = AppF0F0F0Color
        self.view.addSubview(line)
        line.snp.makeConstraints { (make) in
            make.left.equalTo(nameField).offset(40)
            make.right.equalTo(nameField)
            make.top.equalTo(nameField.snp.bottom)
            make.height.equalTo(1)
        }
        
        pwdField = UITextField.createInputField("icon_login_pwd", "请输入密码", true)
        pwdField.font = UIFont.systemFont(ofSize: 15)
        pwdField.delegate = self
        pwdField.text = "123456"
        pwdField.isSecureTextEntry = true
        pwdField.clipsToBounds = true
        pwdField.returnKeyType = .done
        self.view.addSubview(pwdField)
        pwdField.snp.makeConstraints { (make) in
            make.left.equalTo(40)
            make.right.equalTo(-40)
            make.top.equalTo(line.snp.bottom).offset(12)
            make.height.equalTo(40)
        }
        let line1 = UIView()
        line1.backgroundColor = AppF0F0F0Color
        self.view.addSubview(line1)
        line1.snp.makeConstraints { (make) in
            make.left.equalTo(pwdField).offset(40)
            make.right.equalTo(pwdField)
            make.top.equalTo(pwdField.snp.bottom)
            make.height.equalTo(1)
        }
        
        let loginBtn = UIButton()
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.layer.cornerRadius = 20.0
        loginBtn.backgroundColor = AppThemeColor
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        loginBtn.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        self.view.addSubview(loginBtn)
        loginBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(line1.snp.bottom).offset(40)
            make.left.right.equalTo(pwdField)
            make.height.equalTo(40)
        })
        
        linemsg = UILabel()
        linemsg.text = "其他登录方式"
        linemsg.backgroundColor = .white
        linemsg.textAlignment = .center
        linemsg.textColor = App999999Color
        linemsg.font = UIFont.systemFont(ofSize: 13)
        self.view.addSubview(linemsg)
        linemsg.snp.makeConstraints({ (make) in
            make.centerX.equalTo(self.view)
            make.top.equalTo(loginBtn.snp.bottom).offset(40)
            make.width.equalTo(120)
        })
        
        wecharBtn = UIButton()
        wecharBtn.setImage(UIImage.init(named: "login_icon_wechat"), for: .normal)
        wecharBtn.imageView?.contentMode = .scaleAspectFit
        wecharBtn.addTarget(self, action: #selector(wechatlogin), for: .touchUpInside)
        self.view.addSubview(wecharBtn)
        wecharBtn.snp.makeConstraints({ (make) in
            make.top.equalTo(linemsg.snp.bottom).offset(32)
            make.centerX.equalTo(self.view)
            make.width.height.equalTo(48)
        })
        
        let btnBgView = UIView()
        btnBgView.backgroundColor = UIColor.colorWitHex(rgb16Str: 0xeeeeee)
        btnBgView.layer.cornerRadius = 18.0
        self.view.addSubview(btnBgView)
        btnBgView.snp.makeConstraints({ (make) in
            make.bottom.equalTo(nameField.snp.top).offset(-24)
            make.centerX.equalToSuperview()
            make.width.equalTo(240)
            make.height.equalTo(36)
        })
        
        let masterBtn = UIButton()
        masterBtn.clipsToBounds = true
        masterBtn.setTitle("博客", for: .normal)
        masterBtn.setTitleColor(App555555Color, for: .normal)
        masterBtn.setTitleColor(.white, for: .selected)
        masterBtn.backgroundColor = UIColor.init(white: 1.0, alpha: 0.0)
        masterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        masterBtn.addTarget(self, action: #selector(chooseLoginTypeAction(_:)), for: .touchUpInside)
        masterBtn.tag = 1000
        masterBtn.layer.cornerRadius = 15.0
        btnBgView.addSubview(masterBtn)
        masterBtn.snp.makeConstraints({ (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.right.equalTo(btnBgView.snp.centerX)
        })
        let findMasterBtn = UIButton()
        findMasterBtn.clipsToBounds = true
        findMasterBtn.setTitle("管理员", for: .normal)
        findMasterBtn.setTitleColor(App555555Color, for: .normal)
        findMasterBtn.setTitleColor(.white, for: .selected)
        findMasterBtn.backgroundColor = UIColor.init(white: 1.0, alpha: 0.0)
        findMasterBtn.tag = 1001
        findMasterBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        findMasterBtn.addTarget(self, action: #selector(chooseLoginTypeAction(_:)), for: .touchUpInside)
        findMasterBtn.layer.cornerRadius = 15.0
        btnBgView.addSubview(findMasterBtn)
        findMasterBtn.snp.makeConstraints({ (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.left.equalTo(btnBgView.snp.centerX)
        })
        
        let logoImg = UIImageView.init()
        logoImg.image = UIImage.init(named: "")
        logoImg.contentMode = .scaleAspectFill
        self.view.addSubview(logoImg)
        logoImg.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(180)
            make.bottom.equalTo(btnBgView.snp.top).offset(-64)
        })
        
        if !WXApi.isWXAppInstalled() {
            linemsg.isHidden = true
            wecharBtn.isHidden = true
        }
    }
    
    // 登录
    @objc func loginAction() {
        guard nameField.text?.count ?? 0 > 0 else {
            MBProgressHUD.wj_showError("请输入手机号码")
            return
        }
        guard pwdField.text?.count ?? 0 > 0 else {
            MBProgressHUD.wj_showError("请输入密码")
            return
        }
        MBProgressHUD.wj_showActivityLoading(to: self.view)
        ApiManagerProvider.request(ApiManager.login(username: nameField.text, password:pwdField.text?.md5Lower() )) { (result) in
            MBProgressHUD.wj_hide(for: self.view)
            if let model = LoginResultModel.mapModel(result) {
                DKUserInfo.shared.updateName(phone: self.nameField.text ?? "")
                DKUserInfo.shared.updateRoleType(usertype: self.selectBtn?.tag == 1000 ? "1" : "2")
                DKUserInfo.shared.updateToken(token: model.token ?? "")
//                if self.selectBtn?.tag == 1000 {
//                    NotificationCenter.default.post(name: .rootChangeNotifi, object: RootStatus.businessHome)
//                }else{
                DKCommonTools.getDetailInfo()
                NotificationCenter.default.post(name: .rootChangeNotifi, object: RootStatus.home)
//                }
            }else{
//                MBProgressHUD.wj_showError("登录失败")
            }
        }
    }
    
    
    // 微信登录
    @objc func wechatlogin() {
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = "wx_oauth_authorization_state"
        DKWXApiManager.shared.type = "\(selectBtn?.tag == 1000 ? 1 : 2)"
        DKWXApiManager.shared.delegate = self
        WXApi.sendAuthReq(req, viewController: self, delegate: DKWXApiManager.shared) { (isOk) in
            print("微信登录发送成功")
        }
    }
    
    // 选择登录类型
    @objc func chooseLoginTypeAction(_ sender:UIButton) {
        guard sender.tag != selectBtn?.tag else {
            return
        }
        selectBtn?.isSelected = false
        selectBtn?.backgroundColor = UIColor.init(white: 1.0, alpha: 0.0)
        sender.isSelected = true
        sender.backgroundColor = AppThemeColor
        selectBtn = sender
    }
    
    /// 微信登录
    func login(_ openid:String, _ access_token:String) {
//        MBProgressHUD.wj_showActivityLoading("正在登录", to: self.view)
//        ApiManagerProvider.request(ApiManager.wechatLogin(openid: openid, access_token: access_token, type: "\(selectBtn?.tag == 1000 ? 1 : 2)")) { (result) in
//            MBProgressHUD.wj_hide(for: self.view)
//            switch result {
//            case .success(let response):
//                let json = try? response.mapString()
//                guard let info = ResponseInfo.deserialize(from: json) else {
//                    MBProgressHUD.wj_showError("登录失败")
//                    return
//                }
//                if info.code == 0000 || info.code == 200, let model = WXLoginResultModel.deserialize(from: json, designatedPath: "data"), let token = model.token {
//                    DKUserInfo.shared.updateToken(token: token)
//                    DKUserInfo.shared.updateUserType(usertype: "\(model.role)")
//                    DKCommonTools.getUserSelfInfo()
//                    //延时1秒执行
//                    let time: TimeInterval = 1.0
//                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time) {
//                        if model.role == 1 {
//                            NotificationCenter.default.post(name: .rootChangeNotifi, object: RootStatus.businessHome)
//                        }else{
//                            NotificationCenter.default.post(name: .rootChangeNotifi, object: RootStatus.masterHome)
//                        }
//                    }
//                }else if info.code == 406 {
//                    let vc = DKBindPhoneViewController()
//                    vc.openid = openid
//                    self.navigationController?.pushViewController(vc, animated: true)
//                }
//            case .failure:
//                MBProgressHUD.wj_showError("登录失败")
//            }
//        }
    }
}

extension DKLoginViewController: UITextFieldDelegate, DKWXApiManagerDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func onResponse(_ result: Bool, _ msg: String?, _ openid: String?, _ token: String?) {
        if result {
            login(openid ?? "", token ?? "")
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}
