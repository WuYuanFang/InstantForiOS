//
//  Models.swift
//  CattleMaster
//
//  Created by yuanfang wu on 2020/2/14.
//  Copyright © 2020 CattleMaster. All rights reserved.
//

import UIKit
import HandyJSON

/// 给外部使用无需 import HandyJSON
typealias ExtensionJSON = HandyJSON

/// 公共返回model
struct DataModel<T> : HandyJSON {
    var message: String = ""
    var code : NSString = ""
    var data : T?
}

struct DataList<T> : HandyJSON {
    var page: Int = 1
    var count : Int = 0
    var list : [T] = []
}

/// data 字段为 null 类型 或者忽略 data 数据
struct ResultData : HandyJSON {}

/// data是string的model
struct StringModel : HandyJSON {
    
}


/// 首页快报
struct HomePageLettersModel : HandyJSON {
    var home_page_letters_id: Int = 0
    var title: String?
    var content: String?
    var created_at: String?
}

/// 首页轮播图
struct HomeBannerModel : HandyJSON {
    var home_banner_id: Int = 0
    var brief: String?
    var url: String?
    var params: String?
    var created_at: String?
}

/// 师傅类型
struct MasterArtisanSkillsDictionariesData: HandyJSON, Codable {
    var artisan_skills_dictionaries_id:String?
    var profession_type_id: Int = 0
    var name: String?
    var created_at:String?
}
struct ProfessionTypeModel : HandyJSON, Codable {
    var profession_type_id: Int = 0
    var name: String?
    var icon: String?
    var created_at: String?
    var ArtisanSkillsDictionariesData:[MasterArtisanSkillsDictionariesData] = []
}

/// 材料商类型列表
struct MerchantTypeModel : HandyJSON, Codable {
    var merchant_product_type_id: Int = 0
    var icon: String?
    var name: String?
    var status: String?
    var created_at: String?
}

/// 用户信息
struct UserInfoModel : HandyJSON, Codable {
    var user_id: String?
    var username: String?
    var nickname: String?
    var user_mobile: String?
    var contact_mobile: String?
    var avatar: String?
    var age: String?
    var sex: Int = 1
    var role: Int = 1
    var is_audit: Int = 0
    var is_disabled: Int = 0
    var last_adcode: String?
    var last_gps: String?
    var openid: String?
    var openid_time: String?
    var last_login_time: String?
    var created_at: String?
    var updated_at: String?
}

/// 师傅列表
struct ProfessionListModel : HandyJSON{
    var artisanData: ArtisanData?
    var user_id: String?
    var username: String?
    var nickname: String?
    var user_mobile: String?
    var contact_mobile: String?
    var avatar: String?
    var age: String?
    var sex: String?
    var role: String?
    var is_audit: String?
    var is_disabled: String?
    var last_adcode: String?
    var last_gps: String?
    var openid: String?
    var openid_time: String?
    var last_login_time: String?
    var created_at: String?
    var updated_at: String?
    var distance:String?
}

/// 材料商列表
struct MerchantListModel : HandyJSON {
    var merchant_id: String?
    var user_id: String?
    var icon: String?
    var name: String?
    var linkman: String?
    var tel: String?
    var type: Int = 0
    var adcode: String?
    var address: String?
    var product: String?
    var business_scope: String?
    var longitude: String?
    var latitude: String?
    var pv: Int = 0
    var is_audit: Int = 0
    var sort: Int = 0
    var status: Int = 1
    var created_at: String?
    var distance: String?
}

/// 师傅详情-师傅评价
struct ArtisanData    : HandyJSON, Codable {
    var user_artisan_info_id: String?
    var user_id: String?
    var status: Int = 0
    var work_area_name: String?
    var work_adcode: Int = 0
    var profession_type_id: Int = 0
    var self_appraisal: String?
    var daily_wage: Int = 0
    var working_age: String?
    var skill_level_0: Int = 0
    var skill_level_1: Int = 0
    var skill_level_2: Int = 0
    var skill_level_3: Int = 0
    var skill_level_4: Int = 0
    var skill_level_5: Int = 0
    var work_longitude: String?
    var work_latitude: String?
    var created_at: String?
    var skill_grade: String = "100"
    var efficiency_grade: String = "100"
    var manner_grade: String = "100"
}
/// 师傅详情Model
struct MasterDetailModel: HandyJSON, Codable {
    var user_id: String?
    var username: String?
    var nickname: String?
    var user_mobile: String?
    var contact_mobile: String?
    var avatar: String?
    var age: String?
    var sex: Int = 1
    var role: Int = 1
    var is_audit: Int = 0
    var is_disabled: Int = 0
    var last_adcode: String?
    var last_longitude: String?
    var last_latitude: String?
    var last_gps: String?
    var openid: String?
    var openid_time: String?
    var last_login_time: String?
    var jpush_id: String?
    var finish_novice_guide: String?
    var created_at: String?
    var updated_at: String?
    var artisanData: ArtisanData?
}

// 课堂列表
struct ClassRoomListModel : HandyJSON {
    var class_room_id: String?
    var title: String?
    var brief: String?
    var content: String?
    var type: Int = 0
    var created_at: String?
    var updated_at: String?
}

// 工程类型
struct TasksTypeModel : HandyJSON, Codable {
    var published_tasks_type_id: Int = 0
    var name: String?
    var created_at: String?
}

// 我的发布列表模型
struct MyPublishListModel : HandyJSON {
    var published_tasks_id: Int = 0
    var user_id: String?
    var status: Int = 0
    var name: String?
    var type: Int = 0
    var adcode: String?
    var longitude: String?
    var latitude: String?
    var detailed_address: String?
    var introduction: String?
    var pv: String?
    var thumb_number: String?
    var demand:String?
    var mission_start_at: String?
    var mission_end_at: String?
    var expiration_date: String?
    var created_at: String?
    var registration_number_data_count: String?
}

// 发布详情
struct PublishDetailModel : HandyJSON {
    var published_tasks_id: Int = 0
    var user_id: String?
    var status: Int = 0
    var name: String?
    var type: Int = 0
    var adcode: String?
    var longitude: String?
    var latitude: String?
    var detailed_address: String?
    var introduction: String?
    var demand: String?
    var pv: String?
    var thumb_number: String?
    var mission_start_at: String?
    var mission_end_at: String?
    var expiration_date: String?
    var created_at: String?
    var registration_number_data_count: String?
    var picData: [PicDataItem] = []
    var merchantData : MerchantData?
    var userData : UserDataItem?
}
struct PicDataItem    : HandyJSON {
    var published_tasks_pic_id: String?
    var published_tasks_id: Int = 0
    var url: String?
    var brief: String?
    var created_at: String?
}

// 附近发布任务列表Model
struct UserDataItem    : HandyJSON {
    var user_id: String?
    var username: String?
    var nickname: String?
    var user_mobile: String?
    var contact_mobile: String?
    var avatar: String?
    var age: String?
    var sex: String?
    var role: String?
    var is_audit: String?
    var is_disabled: String?
    var last_adcode: String?
    var last_longitude: String?
    var last_latitude: String?
    var last_gps: String?
    var openid: String?
    var openid_time: String?
    var last_login_time: String?
    var finish_novice_guide:Int = 0
    var created_at: String?
    var updated_at: String?
}
struct DutyListModel    : HandyJSON {
    var published_tasks_id: Int = 0
    var user_id: String?
    var status: Int = 0
    var name: String?
    var type: Int = 0
    var adcode: String?
    var longitude: String?
    var latitude: String?
    var detailed_address: String?
    var introduction: String?
    var demand: String?
    var pv: Int = 0
    var thumb_number: Int = 0
    var mission_start_at: String?
    var mission_end_at: String?
    var expiration_date: String?
    var created_at: String?
    var distance: String?
    var registration_number_data_count: Int = 0
    var userData:UserDataItem?
}


// 报名列表model
struct RegistrationUserData    : HandyJSON {
    var user_id: String?
    var username: String?
    var nickname: String?
    var user_mobile: String?
    var contact_mobile: String?
    var avatar: String?
    var age: String?
    var sex: String?
    var role: String?
    var is_audit: Int = 0
    var is_disabled: Int = 0
    var last_adcode: String?
    var last_longitude: String?
    var last_latitude: String?
    var last_gps: String?
    var openid: String?
    var openid_time: String?
    var last_login_time: String?
    var created_at: String?
    var updated_at: String?
}
struct RegistrationArtisanData    : HandyJSON {
    var user_artisan_info_id: String?
    var user_id: String?
    var status: Int = 0
    var work_adcode: String?
    var profession_type_id: Int = 0
    var self_appraisal: String?
    var daily_wage: Int = 0
    var working_age: String?
    var skill_level_0: Int = 0
    var skill_level_1: Int = 0
    var skill_level_2: Int = 0
    var skill_level_3: Int = 0
    var skill_level_4: Int = 0
    var skill_level_5: Int = 0
    var work_longitude: String?
    var work_latitude: String?
    var created_at: String?
}
struct RegistrationRecordModel    : HandyJSON {
    var registration_record_id: Int = 0
    var client_user_id: String?
    var artisan_user_id: String?
    var published_tasks_id: String?
    var created_at: String?
    var distance: String?
    var artisanData: RegistrationArtisanData?
    var userData: RegistrationUserData?
}

// 我的任务列表model
struct MyTaskArtisanData    : HandyJSON {
    var user_id: String?
    var username: String?
    var nickname: String?
    var user_mobile: String?
    var contact_mobile: String?
    var avatar: String?
    var age: String?
    var sex: String?
    var role: Int = 0
    var is_audit: Int = 0
    var is_disabled: Int = 0
    var last_adcode: String?
    var last_longitude: String?
    var last_latitude: String?
    var last_gps: String?
    var openid: String?
    var openid_time: String?
    var last_login_time: String?
    var created_at: String?
    var updated_at: String?
}
struct ClientData    : HandyJSON {
    var user_id: String?
    var username: String?
    var nickname: String?
    var user_mobile: String?
    var contact_mobile: String?
    var avatar: String?
    var age: String?
    var sex: String?
    var role: Int = 0
    var is_audit: Int = 0
    var is_disabled: Int = 0
    var last_adcode: String?
    var last_longitude: String?
    var last_latitude: String?
    var last_gps: String?
    var openid: String?
    var openid_time: String?
    var last_login_time: String?
    var created_at: String?
    var updated_at: String?
}
struct MyTaskListModel    : HandyJSON {
    var mission_id: String?
    var status: Int = 0
    var client_user_id: String?
    var artisan_user_id: String?
    var mission_insurance_id: String?
    var daily_wage: Int = 0
    var total_wage: Int = 0
    var mission_deadline: String?
    var mission_actual_deadline: String?
    var actual_total_wage: Int = 0
    var mission_start_at: String?
    var mission_end_at: String?
    var mission_actual_end_at: String?
    var bargain_money: String?
    var actual_payment_amount: Int = 0
    var refund_amount: Int = 0
    var mission_name: String?
    var mission_content: String?
    var adcode: String?
    var longitude: String?
    var latitude: String?
    var workplace_describe: String?
    var created_at: String?
    var evalution_artisan_data_count: Int = 0
    var evalution_client_data_count: Int = 0
    var tip_data_count: Int = 0
    var artisanData: MyTaskArtisanData?
    var clientData: ClientData?
}

// 预付款
struct PayOrderModel: HandyJSON {
    var return_code: String?
    var return_msg: String?
    var appid: String?
    var mch_id: String?
    var nonce_str: String?
    var sign: String?
    var result_code: String?
    var prepay_id: String?
    var trade_type: String?
    var timestamp: String?
    var money: String?
}

// 私人通知消息列表model
struct PrivateMsgListModel : HandyJSON {
    var private_notice_id: String?
    var user_id: String?
    var attach_params: MsgAttahParamTypeModel?
    var type: Int = 0
    var extra: String?
    var is_read: Int = 0
    var title: String?
    var brief: String?
    var content: String?
    var created_at: String?
}

// 系统消息Model
struct SystemMsgListModel : HandyJSON {
    var system_notice_id: String?
    var type: Int = 0
    var title: String?
    var content: String?
    var created_at: String?
    var read_data_count: Int = 0
}

// 经营范围详情model
struct MerchantReadModel    : HandyJSON {
    var merchant_id: String?
    var user_id: String?
    var icon: String?
    var name: String?
    var linkman: String?
    var tel: String?
    var type: Int = 0
    var adcode: String?
    var address: String?
    var product: String?
    var business_scope: String?
    var longitude: String?
    var latitude: String?
    var pv: Int = 0
    var is_audit: Int = 0
    var sort: String?
    var status: Int = 0
    var created_at: String?
    var impression_score_0: Int = 0
    var impression_score_1: Int = 0
    var impression_score_2: Int = 0
    var picData: [PicDataItem] = []
}

// accodeModel
struct ACCodeModel: HandyJSON {
    var value:String?
    var adcode:[String] = []
}

// 任务详情
struct TaskDetailModel : HandyJSON {
    var mission_id: String?
    var status: Int = 0
    var client_user_id: String?
    var artisan_user_id: String?
    var mission_insurance_id: String?
    var daily_wage: Int = 0
    var total_wage: Int = 0
    var mission_deadline: String?
    var mission_actual_deadline: String?
    var actual_total_wage: Int = 0
    var mission_start_at: String?
    var mission_end_at: String?
    var mission_actual_end_at: String?
    var bargain_money: Int = 0
    var actual_payment_amount: Int = 0
    var refund_amount: Int = 0
    var mission_name: String?
    var mission_content: String?
    var adcode: String?
    var longitude: String?
    var latitude: String?
    var workplace_describe: String?
    var created_at: String?
    var artisanData: MyTaskArtisanData?
    var clientData: ClientData?
    var inviationData: InviationData?
    var merchantData:MerchantData?
}

struct InviationData: HandyJSON {
    var mission_invitation: String?
    var client_user_id: String?
    var artisan_user_id: String?
    var published_tasks_id: String?
    var status: Int = 0
    var daily_wage: Int = 0
    var employ_start_at: String?
    var employ_end_at: String?
    var created_at: String?
}

struct MerchantData: HandyJSON {
    var merchant_id: String?
    var user_id: String?
    var icon: String?
    var name: String?
    var linkman: String?
    var tel: String?
    var type: Int = 0
    var adcode: String?
    var address: String?
    var product: String?
    var business_scope: String?
    var longitude: String?
    var latitude: String?
    var pv: String?
    var is_audit: Int = 0
    var sort: Int = 0
    var status: Int = 0
    var created_at: String?
}

// 支付Model
struct PayModel: HandyJSON{
    var return_code: String?
    var return_msg: String?
    var appid: String?
    var mch_id: String?
    var nonce_str: String?
    var sign: String?
    var result_code: String?
    var prepay_id: String?
    var trade_type: String?
    var timestamp: Int = 0
    var money: Int = 0
}

// 消息未读数
struct UnreadMsgCountModel: HandyJSON {
    var system_notice_unread_count: Int = 0
    var private_notice_unread_total: Int = 0
    var total: String?
}

// 消息model里面的attach_params的model
struct MsgAttahParamTypeModel: HandyJSON {
    var published_tasks_id: String? // type1是发布id
    var mission_invitation_id: String? // type2是邀请id
    var mission_id: String? // 3-10都是任务id
    var publishedTasksData: MsgPublishedTasksDataStatusModel?
}
struct MsgPublishedTasksDataStatusModel: HandyJSON {
    var status: Int = 0
}

// 收支明细Model
struct AccountBookListModel: HandyJSON {
    var user_account_book_id: String?
    var user_id: String?
    var type: Int = 0
    var amount: Int = 0
    var explain: String?
    var created_at: String?
}
// 收支明细月份数组model
struct AccountMonthListModel: HandyJSON {
    var monthTime: String?
    var startDateTime: String?
    var endDateTime: String?
    var income: Int = 0
    var expenditure: String?
}
struct AccountDataList : HandyJSON {
    var page: Int = 1
    var count : Int = 0
    var list : [AccountBookListModel] = []
    var monthStatistics : [AccountMonthListModel] = []
}

// 任务未读数
struct TaskUnreadCount: HandyJSON {
    var count: Int = 0
    var aliveCount: Int = 0
}

// 邀请详情中的发布任务的信息model
struct InvitationPublishedTaskData    : HandyJSON {
    var published_tasks_id: String?
    var user_id: String?
    var status: Int = 0
    var name: String?
    var type: Int = 0
    var adcode: String?
    var longitude: String?
    var latitude: String?
    var detailed_address: String?
    var introduction: String?
    var demand: String?
    var pv: String?
    var thumb_number: String?
    var mission_start_at: String?
    var mission_end_at: String?
    var expiration_date: String?
    var created_at: String?
}
// 邀请详情
struct MissionInvitationModel    : HandyJSON {
    var mission_invitation_id: String?
    var client_user_id: String?
    var artisan_user_id: String?
    var published_tasks_id: String?
    var status: Int = 0
    var daily_wage: Int = 0
    var employ_start_at: String?
    var employ_end_at: String?
    var created_at: String?
    var mission_actual_deadline: String?
    var publishedTaskData: InvitationPublishedTaskData?
}

// 微信登录返回
struct WXLoginResultModel: HandyJSON {
    var token:String?
    var role:Int = 1
}

// 检查师傅技能填写完整度
struct CheckMasterInfo: HandyJSON {
    var type: String?
    var val: Int = 1
}
