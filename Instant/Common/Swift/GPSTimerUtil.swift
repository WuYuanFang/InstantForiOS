//
//  TimerUtil.swift
//  CattleMaster
//
//  Created by yuanfang wu on 2020/2/23.
//  Copyright © 2020 CattleMaster. All rights reserved.
//
// 定时
import UIKit
import AMapLocationKit

class GPSTimerUtil: NSObject {
    typealias LocationBlock = (_ latitude:String,_ longitude:String) -> Void
    
    /// 单例
    static let shared = GPSTimerUtil()
    private override init() {
    }
    private var timer:DispatchSourceTimer?
    // 初始化一个自定义的队列
    private var timerQueue = DispatchQueue.init(label: "com.dkx.niuMaster.timerQueue")
    
    
    var locationManager = AMapLocationManager()
    var longitude, latitude:String?
    
    // 单次定位
    func singleGPS(_ isUpdate:Bool=false,_ handler:@escaping (_ latitude:Double,_ longitude:Double,_ address:String?)->Void) {
        // kCLLocationAccuracyBest，可以获取精度很高的一次定位，偏差在十米左右，超时时间请设置到10s，如果到达10s时没有获取到足够精度的定位结果，会回调当前精度最高的结果。
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.locationTimeout = 4
        locationManager.reGeocodeTimeout = 4
        locationManager.requestLocation(withReGeocode: true, completionBlock: { [weak self] (location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
                    
            if let error = error {
                NotificationCenter.default.post(name: .changeHomeData, object: nil)
                let error = error as NSError
                if error.code == AMapLocationErrorCode.locateFailed.rawValue {
                    //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
                    NSLog("定位错误:{\(error.code) - \(error.localizedDescription)};")
                    return
                } else if error.code == AMapLocationErrorCode.reGeocodeFailed.rawValue
                    || error.code == AMapLocationErrorCode.timeOut.rawValue
                    || error.code == AMapLocationErrorCode.cannotFindHost.rawValue
                    || error.code == AMapLocationErrorCode.badURL.rawValue
                    || error.code == AMapLocationErrorCode.notConnectedToInternet.rawValue
                    || error.code == AMapLocationErrorCode.cannotConnectToHost.rawValue {
                    
                    //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
                    NSLog("逆地理错误:{\(error.code) - \(error.localizedDescription)};")
                } else {
                    //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
                }
            }
            if let location = location {
                NSLog("location:%@", location)
                self?.longitude = "\(location.coordinate.longitude)"
                self?.latitude = "\(location.coordinate.latitude)"
                handler(location.coordinate.latitude , location.coordinate.longitude , reGeocode?.poiName)
                if isUpdate { self?.uploadGPS() }
            }
            if let reGeocode = reGeocode {
                NSLog("reGeocode:%@", reGeocode)
            }
        })
    }
    
    // 持续进行定位
    func setup() {
        locationManager.delegate = self
        locationManager.distanceFilter = 200
        locationManager.startUpdatingLocation()
        locationManager.locatingWithReGeocode = true
    }
    
    // 启动定制起，用于定时更新首页的发病时间和到院时间，并通知界面进行数据切换
    func startTimer() {
        
        if timer != nil && !(timer?.isCancelled ?? false) {
            timer?.cancel()
        }
        // 在global线程里创建一个时间源
        timer = DispatchSource.makeTimerSource(queue: timerQueue)
        // 设定这个时间源是每秒循环一次，立即开始
        timer?.schedule(deadline: .now(), repeating: .seconds(5))
        // 设定时间源的触发事件
        timer?.setEventHandler(handler: {
            // 每秒计时一次返回主线程处理一些事件，更新UI等等
            self.uploadGPS()
        })
        // 启动时间源
        timer?.resume()
    }
    
    // 取消时间源
    func cancelTimer() {
        if let time = timer {
            if !time.isCancelled {
                time.cancel()
            }
        }
    }
    

}

extension GPSTimerUtil : AMapLocationManagerDelegate {
    
    func amapLocationManager(_ manager: AMapLocationManager!, didUpdate location: CLLocation!, reGeocode: AMapLocationReGeocode!) {
        print("当前定位经纬度:{lat:\(location.coordinate.latitude); lon:\(location.coordinate.longitude); accuracy:\(location.horizontalAccuracy)};")
        longitude = "\(location.coordinate.longitude)"
        latitude = "\(location.coordinate.latitude)"
    }
    
}

//MARK: 定时上传定位
extension GPSTimerUtil {
    
    func uploadGPS() {
//        guard let _ = DKUserInfo.shared.token else{
//            return
//        }
//        guard let lon = longitude else {
//            return
//        }
//        guard let lat = latitude else {
//            return
//        }
//        let gps = "\(lon),\(lat)"
//        ApiNoLogManagerProvider.request(ApiManager.saveUserSetGps(gps: gps)) { (result) in
//            if let _ = ResultData.mapSuccess(result) {
//                print("上传GPS成功")
//            }
//        }
        
    }

}

