//
//  HMCache.swift
//  HMUIKit
//
//  Created by CNCEMN188807 on 2024/8/29.
//

import UIKit
import Cache_Swift

/// 缓存类
public struct HMCache {
    
    /// app缓存
    public static let appCache = CacheStorage(config: AppCache())
    
    /// 当前选择设备的id
    public static var currentSelectDeviceId = "default"
    /// 设备缓存 不同的设备缓存不同
    public static let deviceCache = CacheStorage(config: DeviceCache())
    
    /// 跟app相关联的缓存
    private struct AppCache: CacheConfigable {
        var name: String {
            return "HMAppCache"
        }
    }
    
    /// 跟Light设备相关联的缓存
    private struct DeviceCache: CacheConfigable {
        var name: String {
            return "HMDeviceCache" + HMCache.currentSelectDeviceId
        }
    }
}

/// 缓存的所有key
extension CacheKey {
    
    /// NightListening相关缓存
    public struct NightListening {
        
        /// 是否显示过NightListening Guide
        public static let isShowdNightListeningGuide = CacheKey("CacheKey.NightListening.isShowdNightListeningGuide")
    }
}
