//
//  HMCacheConfigable.swift
//  stick_ios
//
//  Created by CNCEMN188807 on 2024/1/25.
//

import UIKit
import Cache

/// Cache配置协议
public protocol CacheConfigable {
    
    /// 缓存名称
    var name: String { get }
    
    /// 缓存目录
    var directory: URL? { get }
}

public extension CacheConfigable {
    
    var name: String {
        return "Default"
    }
    
    var directory: URL? {
        let cacheUrl = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent("Cache")
//        debugPrint("cacheUrl: \(String(describing: cacheUrl?.absoluteString))")
        return cacheUrl
    }
    
    /// 是否等于另一个配置
    func isEqualTo(_ other: CacheConfigable) -> Bool {
        if self.name == other.name && self.directory?.absoluteString == other.directory?.absoluteString {
            return true
        } else {
            return false
        }
    }
}

