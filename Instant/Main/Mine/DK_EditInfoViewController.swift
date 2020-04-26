//
//  DK_EditInfoViewController.swift
//  Instant
//
//  Created by yuanfang wu on 2020/4/26.
//  Copyright © 2020 yuanfang wu. All rights reserved.
//

import UIKit
import DropDown
import TZImagePickerController

class DK_EditInfoViewController: DKBaseViewController {
    
    var headImg: UIImageView!
    var nameField, birthField, sexField, phoneField: UITextField!
    var selGender:Int = 1
    var headPath:String?
    let genderArr = ["男", "女", "未知"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "个人信息"
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "保存", style: .plain, target: self, action: #selector(saveAction))
        setupUI()
        getDetailInfo()
    }
    
    func setupUI() {
        let imgLabel = UILabel()
        imgLabel.text = "头像"
        imgLabel.numberOfLines = 0
        imgLabel.font = UIFont.systemFont(ofSize: 16)
        imgLabel.textColor = App333333CGolor
        view.addSubview(imgLabel)
        imgLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.height.equalTo(48)
            make.top.equalToSuperview()
        }
        headImg = UIImageView()
        headImg.contentMode = .scaleAspectFill
        headImg.layer.cornerRadius = 24
        headImg.clipsToBounds = true
        view.addSubview(headImg)
        headImg.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.height.width.equalTo(48)
            make.centerY.equalTo(imgLabel)
        }
        let line = UIView.createLine(imgLabel, view)
        nameField = UITextField.createField("昵称", "请输入昵称")
        nameField.delegate = self
        view.addSubview(nameField)
        nameField.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(line.snp.bottom)
            make.height.equalTo(48)
            make.right.equalTo(-12)
        }
        let line1 = UIView.createLine(nameField, view)
        sexField = UITextField.createField("性别", "请选择性别")
        sexField.delegate = self
        view.addSubview(sexField)
        sexField.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(line1.snp.bottom)
            make.height.equalTo(48)
            make.right.equalTo(-12)
        }
        let line3 = UIView.createLine(sexField, view)
        phoneField = UITextField.createField("手机号码", "请输入手机号码")
        phoneField.keyboardType = .phonePad
        phoneField.delegate = self
        view.addSubview(phoneField)
        phoneField.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(line3.snp.bottom)
            make.height.equalTo(48)
            make.right.equalTo(-12)
        }
        let _ = UIView.createLine(phoneField, view)
        
    }
    
    
    // 更换头像
    @objc func changeHeaderAction() {
        let imagePicker = TZImagePickerController.init(maxImagesCount: 1, delegate: self)
        imagePicker?.naviBgColor = AppThemeColor
        imagePicker?.allowPickingVideo = false
        self.present(imagePicker!, animated: true, completion: nil)
    }

}

// 获取图片时的回调
extension DK_EditInfoViewController : TZImagePickerControllerDelegate, UITextFieldDelegate {
    
    func imagePickerController(_ picker: TZImagePickerController!, didFinishPickingPhotos photos: [UIImage]!, sourceAssets assets: [Any]!, isSelectOriginalPhoto: Bool) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == sexField {
            textField.endEditing(true)
            let dropView = DropDown()
            dropView.dataSource = genderArr
            dropView.anchorView = textField
            dropView.selectionAction = {(index, item) in
                textField.text = item
                self.selGender = index + 1
            }
            dropView.show()
            return false
        }
        return true
    }
    
}

extension DK_EditInfoViewController {
    
    func getDetailInfo() {
        ApiManagerProvider.request(.getDetailInfo) { (result) in
            if let model = UserInfoModel.mapModel(result) {
                self.nameField.text = model.nickname
                self.selGender = model.gender
                self.phoneField.text = model.phone
                self.sexField.text = GenderType.init(rawValue: model.gender)?.toString()
                self.headPath = model.headPath
            }
        }
    }
    
    @objc func saveAction() {
        ApiManagerProvider.request(.saveUserInfo(id: nil, username: nil, actualName: nil, nickname: nameField.text, gender: "\(selGender)", idCard: nil, phone: phoneField.text, headPath: headPath)) { (result) in
            if let _ = ResultData.mapSuccess(result, toast: true) {
                if let block = self.normalBlock {
                    block()
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
