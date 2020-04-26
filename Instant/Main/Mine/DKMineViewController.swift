//
//  DKMineViewController.swift
//  Instant
//
//  Created by yuanfang wu on 2020/4/26.
//  Copyright © 2020 yuanfang wu. All rights reserved.
//

import UIKit

class DKMineViewController: DKBaseViewController {

    let cellArr = ["我的时刻", "设置"]
    let cellImgs = ["icon_mine_time", "icon_mine_setting"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "我的"
        setupUI()
        getDetailInfo()
    }
    
    func setupUI() {
        let headView = UIView()
        headView.backgroundColor = AppThemeColor.withAlphaComponent(0.1)
        view.addSubview(headView)
        view.addSubview(tableView)
        headView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(160)
        }
        tableView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(headView.snp.bottom)
            make.bottom.equalTo(-56)
        }
        headView.addSubview(headImg)
        headImg.isUserInteractionEnabled = true
        let tapG = UITapGestureRecognizer(target: self, action: #selector(goDetail))
        headImg.addGestureRecognizer(tapG)
        headImg.snp.makeConstraints { (make) in
            make.top.equalTo(40)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(54)
        }
        headView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(headImg.snp.bottom).offset(12)
            make.left.right.equalToSuperview()
        }
        
        
        let saveBtn = UIButton()
        saveBtn.setTitle("退出登录", for: .normal)
        saveBtn.setTitleColor(AppThemeColor, for: .normal)
        saveBtn.layer.cornerRadius = 5.0
        saveBtn.layer.borderColor = AppThemeColor.cgColor
        saveBtn.layer.borderWidth = 0.6
        saveBtn.addTarget(self, action: #selector(loginoutAction), for: .touchUpInside)
        self.view.addSubview(saveBtn)
        saveBtn.snp.makeConstraints({ (make) in
            make.bottom.equalTo(-FootSafeHeight-TabBarHeight-12)
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(40)
        })
    }
    
    @objc func goDetail() {
        let vc = DK_EditInfoViewController()
        vc.normalBlock = { ()in
            self.getDetailInfo()
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginoutAction() {
        DKCommonTools.loginOut()
    }
    
    // 头像
    lazy var headImg: UIImageView = {
        let v = UIImageView()
        v.clipsToBounds = true
        v.layer.cornerRadius = 27.0
        v.layer.borderColor = UIColor.white.cgColor
        v.layer.borderWidth = 1.0
        v.image = UIImage(named: "icon_mine_head")
        v.contentMode = .scaleAspectFill
        return v
    }()
    // 名字
    lazy var nameLabel: UILabel = {
        let v = UILabel()
        v.textAlignment = .center
        v.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight(10))
        v.textColor = .white
        return v
    }()
    
    lazy var tableView: UITableView = {
        let v = UITableView()
        v.delegate = self
        v.dataSource = self
        v.rowHeight = 54
        v.isScrollEnabled = false
        v.tableFooterView = UIView()
        v.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "UITableViewCell")
        return v
    }()

}

extension DKMineViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.selectionStyle = .none
        cell.textLabel?.text = cellArr[indexPath.row]
        cell.textLabel?.textColor = App333333CGolor
        cell.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell.imageView?.image = UIImage(named: cellImgs[indexPath.row])
        cell.imageView?.contentMode = .scaleAspectFit
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellName = cellArr[indexPath.row]
        switch cellName {
        default:
            break
        }
    }
}


//MARK: 请求扩展
extension DKMineViewController {
    
    func getDetailInfo() {
        ApiManagerProvider.request(.getDetailInfo) { (result) in
            if let model = UserInfoModel.mapModel(result) {
                self.nameLabel.text = model.nickname
                DKUserInfo.shared.userInfo = model
            }
        }
    }
    
    
}
