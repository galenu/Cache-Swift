//
//  HMCacheKey.swift
//  stick_ios
//
//  Created by CNCEMN188807 on 2024/1/25.
//

import UIKit

/// 缓存的key
public struct CacheKey: Hashable, Equatable, RawRepresentable {
    
    public var rawValue: String
    
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    public init(_ key: String) {
        self.rawValue = key
    }
}
