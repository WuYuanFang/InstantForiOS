//
//  EnumExtension.swift
//  HospitalWorkStation
//
//  Created by 吴远房 on 2019/10/14.
//  Copyright © 2019 吴远房. All rights reserved.
//
// 所有的枚举类
import UIKit

//MARK: 根目录的跳转类型
enum RootStatus {
    case login                // 前往登录页
    case home           // 师傅首页作为根目录
}

// 实名认证状态
enum CertifiStatus:Int {
    case none = 200     // 未实名
    case doing = 502    // 审核中
    case done = 501     // 已实名
    case other = 0000   // 未知
}

// 师傅技能完成度
enum MasterSkillInfoStatus: Int {
    case done = 0
    case professional_settings = 1
    case daliy_wage_settings = 2
    case work_area_settings = 3
    case other = -1
}

enum CacheType: String {
    case UserInfo = "UserInfoCache" // 用户信息
    case MasterInfo = "MasterInfoCache" // 师傅信息
    case ProfessionType = "ProfessionTypeCache" // 师傅类型
    case MerchantType = "MerchantType"  // 商家类型、经营范围
    case TaskType = "TaskTypeCache" //发布类型
}

//MARK: 我的任务的单的类型
enum MyTaskType:Int {
    case getNoPay=0       // 师傅已接单，未付款：师傅同意了客户的任务邀请，任务建立。客户未支付
    case getAndPay=1      // 已接单已付款：客户支付了项目预付款，自动转换为已接单已付款
    case doneNoPay=2      // 已完工，未确定付款：到达是任务截止时间，任务自动转换为已完成未确认。
    case doneAndPay=3     // 已完工，已确定付款：
    case endNoPay=4       // 任务已终止，未确定付款：任务处于已完成未确认的状态，此时师傅确认完成，则转为已完成已确认状态
    case endAndPay=5      // 任务已终止，已确认付款：
    case cancelOrder=6    // 取消订单：客户未支付预付款，客户申请取消订单，直接转换为取消订单。
    
    func translate(_ isClient:Bool = true) -> String {
        if isClient {
            switch self {
            case .getNoPay: return "师傅已接单，未付款"
            case .getAndPay: return "已付款，师傅工作中"
            case .doneNoPay: return "已完工，未确定付款"
            case .doneAndPay: return "已完工，已确认付款"
            case .endNoPay: return "任务已终止，未确定付款"
            case .endAndPay: return "任务已终止，已确认付款"
            case .cancelOrder: return "订单已取消"
            }
        }else{
            switch self {
            case .getNoPay: return "已接单，等待付款"
            case .getAndPay: return "已付款，任务进行中"
            case .doneNoPay: return "已完工，未确认"
            case .doneAndPay: return "已完工，已确认"
            case .endNoPay: return "任务已终止，未确认"
            case .endAndPay: return "任务已终止，已确认"
            case .cancelOrder: return "订单已取消"
            }
        }
    }
    
    func showColor(_ isClient:Bool = true) -> UIColor {
        if isClient {
            switch self {
            case .getNoPay: return AppThemeYellowColor
            case .getAndPay: return AppGreenColor
            case .doneNoPay, .doneAndPay, .endNoPay, .endAndPay: return AppBlueColor
            case .cancelOrder: return AppRedColor
            }
        }else{
            switch self {
            case .getNoPay: return AppThemeYellowColor
            case .getAndPay: return AppGreenColor
            case .doneNoPay, .doneAndPay, .endNoPay, .endAndPay: return AppBlueColor
            case .cancelOrder: return AppRedColor
            }
        }
    }
    
    func btnsArr(_ isClient:Bool = true) -> [String] {
        if isClient {// 找师傅端
            switch self {
            case .getNoPay: return ["去付款", "取消订单"]
            case .doneNoPay, .endNoPay: return ["确定付款"]
            case .doneAndPay, .endAndPay: return ["打赏师傅", "评价师傅"]
            default: return []
            }
        }else{
            // 师傅端
            switch self {
            case .getAndPay: return ["终止任务", "去导航"]
            case .getNoPay, .doneNoPay, .endNoPay: return ["联系他"]
            case .doneAndPay, .endAndPay: return ["立即评价"]
            default: return []
            }
        }
    }
}

//MARK: 师傅直通车类型
enum ProfressType: NSInteger {
    case GuangGao = 1001
    case ZuoZhi
    case MuGong
    case ShuiDian
    case PiHui
    case CiZhuan
    case MenChuang
    case ZaGong
    case ZuJiaoShouJia
    case DiaoCheChaChe
    
    static func imgStr(_ param:NSInteger) -> String {
        switch ProfressType.init(rawValue: param) ?? .GuangGao {
        case .GuangGao:return "icon_Installationad"
        case .ZuoZhi:return "icon_welder"
        case .MuGong:return "icon_decoration1"
        case .ShuiDian:return "icon_hydropower"
        case .PiHui:return "icon_paint"
        case .CiZhuan:return "icon_searchtask1"
        case .MenChuang:return "icon_wardrobe"
        case .ZaGong:return "icon_cleaner"
        case .ZuJiaoShouJia:return "icon_scaffold"
        case .DiaoCheChaChe:return "icon_crane"
        }
    }
    static func imgSelStr(_ param:NSInteger) -> String {
        switch ProfressType.init(rawValue: param) ?? .GuangGao {
        case .GuangGao:return "business_icon_Installationad_click"
        case .ZuoZhi:return "business_icon_welder_click"
        case .MuGong:return "business_icon_decoration_click"
        case .ShuiDian:return "business_icon_hydropower_click"
        case .PiHui:return "business_icon_paint_click"
        case .CiZhuan:return "business_icon_searchtask_click"
        case .MenChuang:return "business_icon_wardrobe_click"
        case .ZaGong:return "business_icon_cleaner_click"
        case .ZuJiaoShouJia:return "business_icon_scaffold_click"
        case .DiaoCheChaChe:return "business_icon_crane_click"
        }
    }
    
}

//MARK: 材料商类型
enum MerchantType: NSInteger {
    case ph = 1001
    case ggcl
    case led
    case kaiGuan
    case dengXiang
    case sheBei
    case wuJin
    case zhuangShiCaiLiang
    case ciZhuan
    case chuGui
    case menChuang
    case dengJu
    case GuangGao
    case zhuangShiCompany
    case other
    
    static func imgNormalStr(_ param:NSInteger) -> String {
        switch MerchantType.init(rawValue: param) ?? .ph {
        case .ph:return "icon_ph_normal"
        case .ggcl:return "icon_ggcl_normal"
        case .led:return "icon_led_normal"
        case .kaiGuan:return "icon_open_normal"
        case .dengXiang:return "icon_deng_normal"
        case .sheBei:return "icon_shebeil_normal"
        case .wuJin:return "icon_god_normal"
        case .zhuangShiCaiLiang:return "icon_ad_normal"
        case .ciZhuan:return "icon_yg_normal"
        case .chuGui:return "icon_yg_normal"
        case .menChuang:return "icon_door_normal"
        case .dengJu:return "icon_light_normal"
        case .GuangGao:return "icon_zhuangxiu_normal"
        case .zhuangShiCompany:return "icon_zhuangxiu_normal"
        case .other:return "icon_others_normal"
        }
    }
    static func imgSelectStr(_ param:NSInteger) -> String {
        switch MerchantType.init(rawValue: param) ?? .ph {
        case .ph:return "icon_penhui_click"
        case .ggcl:return "icon_ggcl_click"
        case .led:return "icon_led_click"
        case .kaiGuan:return "icon_open_click"
        case .dengXiang:return "icon_deng_click"
        case .sheBei:return "icon_shebei_click"
        case .wuJin:return "icon_god_click"
        case .zhuangShiCaiLiang:return "icon_ad_click"
        case .ciZhuan:return "icon_yigui_click"
        case .chuGui:return "icon_yigui_click"
        case .menChuang:return "icon_door_click"
        case .dengJu:return "icon_dengju_click"
        case .GuangGao:return "icon_zhuangxiu_click"
        case .zhuangShiCompany:return "icon_zhuangxiu_click"
        case .other:return "icon_others_click"
        }
    }
    
}

// 文本显示类型
enum TextType {
    case classRoom
    case message
}

// 消息类型
enum MessageType:Int {
    case text = 0   // 普通文本
    case dutyDoneNoPay = 7  // 已到达任务完成时间、师傅和客户 收到任务已完成未确认通知
    case clientConfirmBringForwardDone = 10 // 客户确认提前终止，师傅和客户 收到通知
    // 师傅
    case master_invite = 2  // 当客户向已报名的师傅发送邀请时，师傅会收到通知
    case master_clientAdvancePay = 5 // 客户支付了预付款，师傅将收到一条通知
    case master_clientCancelDuty = 6 // 客户取消了任务 [查看我的任务]
    case master_clientConfirmDone = 8 // 客户确认任务完成
    // 客户
    case client_masterEnroll = 1 // 师傅报名了工程，当报名成功后，客户收到报名通知
    case client_masterAgreeInvite = 3 // 师傅同意了邀请，将收到一条同意邀请的通知
    case client_masterRefuseInvite = 4 // 师傅拒绝了客户的邀请
    case client_masterBringForwardDone = 9 // 师傅提前终止任务，客户将收到任务提前终止未确认的通知
    
    func btnArr() -> [String] {
        switch self {
        case .master_invite:
            return ["邀请详情"]
        case .master_clientAdvancePay, .master_clientCancelDuty, .master_clientConfirmDone, .client_masterAgreeInvite:
            return ["查看我的订单"]
        case .client_masterEnroll:
            return ["报名列表"]
        case .client_masterBringForwardDone, .dutyDoneNoPay, .clientConfirmBringForwardDone:
            return ["订单详情"]
        case .client_masterRefuseInvite:
            return ["我的发布"]
        default:
            return []
        }
    }
    
}
