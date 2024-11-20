//
//  HMCacheable.swift
//  stick_ios
//
//  Created by CNCEMN188807 on 2024/1/30.
//

import UIKit

public protocol Cacheable {
    
    /// 从缓存中获取Data
    func object(forKey: CacheKey) -> Data?
    
    /// 缓存Data
    func setObject(_ data: Data, forKey: CacheKey)
    
    /// 缓存Codable对象
    /// - Parameters:
    ///   - forKey: 缓存key
    ///   - type: 缓存Codable对象类型
    /// - Returns: 从缓存中获取的Codable对象
    func object<T: Codable>(forKey: CacheKey, type: T.Type) -> T?
    
    /// 缓存Codable对象
    /// - Parameters:
    ///   - object: 缓存Codable对象
    ///   - forKey: 缓存key
    func setObject(_ object: Codable, forKey: CacheKey)
    
    /// 移除缓存对象
    func removeObject(forKey: CacheKey)
    
    func removeAll()
    
    func existsObject(forKey: CacheKey) -> Bool
    
    func asyncObject(forKey: CacheKey, completion: @escaping ((Data) -> Void), failure: ((Error) -> Void)?)
    
    func asyncSetObject(_ data: Data, forKey: CacheKey, completion: (() -> Void)?, failure: ((Error) -> Void)?)
    
    func asyncObject<T: Codable>(forKey: CacheKey, type: T.Type, completion: @escaping ((T) -> Void), failure: ((Error) -> Void)?)
    
    func asyncSetObject(_ object: Codable, forKey: CacheKey, completion: (() -> Void)?, failure: ((Error) -> Void)?)
    
    func asyncRemoveObject(forKey: CacheKey, completion: (() -> Void)?, failure: ((Error) -> Void)?)
    
    func asyncRemoveAll(completion: (() -> Void)?, failure: ((Error) -> Void)?)
    
    func asyncExistsObject(forKey: CacheKey, completion: ((Bool) -> Void)?)
}
