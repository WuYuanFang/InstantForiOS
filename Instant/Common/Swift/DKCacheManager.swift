//
//  DK_CacheManager.swift
//  HospitalWorkStation
//
//  Created by 吴远房 on 2019/8/14.
//  Copyright © 2019 吴远房. All rights reserved.
//

import UIKit

public class DKCacheManager {
    
    private var directoryPath: String?
    private var directoryUrl: URL?
    private var fileManager: FileManager {
        return FileManager.default
    }
    
    // 初始化一个自定义的队列
    private var cacheQueue = DispatchQueue.init(label: "com.dkx.CattleMaster.cacheQueue")
    
    
    public static var shared = DKCacheManager.init(cacheName: Bundle.main.infoDictionary?["CFBundleName"] as? String ?? "DKAppCache")
    
    
    //MARK:------初始化------
    private init() {}
    
    /// 这个初始化方法将会使用~/Library/Caches/com.nikkscache.dev/targetName去保存数据
    ///
    /// - Parameter cacheName:  缓存的名字 (默认是 'TargetName')
    private init(cacheName: String) {
        if let cacheDirectory = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last {
            // 获取/Library/Caches文件夹路径
            
            let dir = cacheDirectory + "/com.dkx.CattleMaster/" + cacheName
            directoryPath = dir
            directoryUrl = URL.init(fileURLWithPath: dir)
            
            if fileManager.fileExists(atPath: dir) == false {
                do {
                    try fileManager.createDirectory(atPath: dir, withIntermediateDirectories: true, attributes: nil)
                }catch{}
            }
        }
    }
    
    //MARK:------获取目录下的所有缓存文件列表------
    func getFileListFromDirectory() -> [String]? {
        do{
            let fileArr = try fileManager.contentsOfDirectory(atPath: directoryPath ?? "")
            return fileArr
        }catch{
            return nil
        }
    }
    
    //MARK:------添加/删除 缓存数据------
    /// 通过key值写入一个对象（泛型对象）到缓存文件夹
    ///
    /// - Parameters:
    ///   - object: 需要写入的对象
    ///   - key: 写入对象对应的key值
    func setObject<T: Codable>(_ object: T, forKey key:String) {
        cacheQueue.async { [weak self] in
            // 在自定义的队列中执行异步线程
            guard let path = self?.pathForKey(key) else {
                print("文件对应的key值无法找到")
                return
            }
            do {
                let data = try PropertyListEncoder().encode(object)
//                if #available(iOS 12.0, *) {
//                    let data = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
//                    try data.write(to: URL.init(fileURLWithPath: path), options: .atomic)
//                }else {
                let success = NSKeyedArchiver.archiveRootObject(data, toFile: path)
                print(success ? "数据保存成功" : "数据缓存失败")
//                }
            }catch{
                print("数据缓存失败")
            }
        }
    }
    
    /// 删除对应的key的缓存数据
    ///
    /// - Parameter key: 缓存数据对应的key
    func removeObjectForKey(_ key:String) {
        cacheQueue.async { [weak self] in
            // 在自定义的队列中执行异步线程
            guard let path = self?.pathForKey(key) else {
                print("文件对应的key值无法找到")
                return
            }
            do {
                try self?.fileManager.removeItem(atPath: path)
                print("数据删除成功")
            }catch{
                print("数据删除失败")
            }
        }
    }
    
    /// 删除所有缓存数据
    func removeAllObjects() {
        cacheQueue.async { [weak self] in
            guard let `self` = self else{ return }
            guard let directoryUrls = self.directoryUrl else { return }
            do {
                try self.fileManager.contentsOfDirectory(at: directoryUrls, includingPropertiesForKeys: nil, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles).forEach({ (url) in
                    do{
                        try self.fileManager.removeItem(at: url)
                        print("数据全部删除成功")
                    }catch{
                        print("数据删除失败")
                    }
                })
            }catch{
                print("数据删除失败")
            }
        }
    }
    
    
    /// 通过线程队列进行获取对应key的缓存数据，然后回调到主线程
    ///
    /// - Parameters:
    ///   - key: 数据对应的key
    ///   - completionHandler:  获取到数据并回调
    func getObjectForKey<T: Codable>(_ key: String, completionHandler: @escaping (T?)->()) {
        cacheQueue.async { [weak self] in
            guard let path = self?.pathForKey(key) else {
                print("文件对应的key值无法找到")
                return
            }
            guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? Data else {
                print("获取数据失败")
                DispatchQueue.main.async {
                    // 回调到主线程
                    completionHandler(nil)
                }
                return
            }
            do {
                let object = try PropertyListDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    // 获取数据成功,将数据回调到主线程
                    completionHandler(object)
                }
            }catch {
                print("获取数据失败")
                DispatchQueue.main.async {
                    // 回调到主线程
                    completionHandler(nil)
                }
            }
        }
    }
    
    
    /// 获取对应key的缓存数组数据
    ///
    /// - Parameters:
    ///   - key: 数据对应的key
    ///   - completionHandler:  获取到数据并回调
    func getObjectsForKey<T: Codable>(_ key: String, completionHandler: @escaping ([T]?)->()) {
        cacheQueue.async { [weak self] in
            guard let path = self?.pathForKey(key) else {
                print("文件对应的key值无法找到")
                return
            }
            guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? Data else {
                print("获取数据失败")
                DispatchQueue.main.async {
                    // 回调到主线程
                    completionHandler(nil)
                }
                return
            }
            do {
                let object = try PropertyListDecoder().decode(Array<T>.self, from: data)
                DispatchQueue.main.async {
                    // 获取数据成功,将数据回调到主线程
                    completionHandler(object)
                }
            }catch {
                print("获取数据失败")
                DispatchQueue.main.async {
                    // 回调到主线程
                    completionHandler(nil)
                }
            }
        }
    }
    
    /// 直接在主线程获取对应key的缓存数据然后返回
    ///
    /// - Parameters:
    ///   - key: 数据对应的key
    ///   - completionHandler:  获取到数据并回调
    func getObjectForKeyDirect<T: Codable>(_ key: String) -> T? {
        guard let path = self.pathForKey(key) else {
            print("文件对应的key值无法找到")
            return nil
        }
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? Data else {
            print("获取数据失败")
            return nil
        }
        do {
            let object = try PropertyListDecoder().decode(T.self, from: data)
            // 获取数据成功,将数据回调到主线程
            return object
        }catch {
            print("获取数据失败")
            return nil
        }
    }
    
    
    //MARK: - Private Methods
    private func pathForKey(_ key: String)->String?{
        return directoryUrl?.appendingPathComponent(key).path
    }
    
    /// 使用此方法是因为根据应用程序商店审查指南/iOS数据存储指南，需要从iCloud上备份文件
    ///
    /// - Parameter fileUrl: 文件的url路径是否包括来自备份
    /// - Returns:
    @discardableResult
    private func excludeFromBackup(fileUrl: inout URL) ->Bool {
        if fileManager.fileExists(atPath: fileUrl.path) {
            fileUrl.setTemporaryResourceValue(true, forKey: URLResourceKey.isExcludedFromBackupKey)
            return true
        }
        return false
    }
    
}

