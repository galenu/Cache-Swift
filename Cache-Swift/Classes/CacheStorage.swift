//
//  HMCacheStorage.swift
//  stick_ios
//
//  Created by CNCEMN188807 on 2024/1/25.
//

import UIKit
import Cache

/// Cache提供的方法
public class CacheStorage {
    
    /// 缓存配置
    private var config: CacheConfigable
    
    private var storage: Storage<String, Data>? {
        
        if let _oldDiskConfig = _oldDiskConfig, self.config.isEqualTo(_oldDiskConfig)  { // 创建过storage 比较配置 配置有改变再重新创建
            return _oldStorage
        } else { // 没有则新建
            let diskConfig = DiskConfig(name: config.name, expiry: .never, directory: config.directory, protectionType: .complete)
            _oldDiskConfig = config
            let memoryConfig = MemoryConfig()
            
            let transformer = TransformerFactory.forData()
            _oldStorage = try? Storage<String, Data>(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: transformer)
            return _oldStorage
        }
    }
    /// 旧的Storage
    private var _oldStorage: Storage<String, Data>?
    /// 旧的缓存配置
    private var _oldDiskConfig: CacheConfigable?

    public init(config: CacheConfigable) {
        self.config = config
    }
}

extension CacheStorage: Cacheable {
    
    public func object(forKey: CacheKey) -> Data? {
        guard let data = try? self.storage?.object(forKey: forKey.rawValue) else { return nil }
        return data
    }
    
    public func setObject(_ data: Data, forKey: CacheKey) {
        try? self.storage?.setObject(data, forKey: forKey.rawValue)
    }
    
    public func object<T: Codable>(forKey: CacheKey, type: T.Type) -> T? {
        guard let data = self.object(forKey: forKey) else { return nil }
        let result = CacheSerializer.formData(data: data, type: type)
        return result
    }
    
    public func setObject(_ object: Codable, forKey: CacheKey) {
        let data = CacheSerializer.toData(object: object)
        self.setObject(data, forKey: forKey)
    }
    
    public func removeObject(forKey: CacheKey) {
        try? self.storage?.removeObject(forKey: forKey.rawValue)
    }

    public func removeAll() {
        try? self.storage?.removeAll()
    }
    
    public func existsObject(forKey: CacheKey) -> Bool {
        return (try? self.storage?.existsObject(forKey: forKey.rawValue)) ?? false
        
    }
    
    // MARK: - 异步缓存
    
    public func asyncObject(forKey: CacheKey, completion: @escaping ((Data) -> Void), failure: ((Error) -> Void)? = nil) {
        self.storage?.async.object(forKey: forKey.rawValue) { result in
            switch result {
            case let .value(data):
                DispatchQueue.main.async {
                    completion(data)
                }
            case let .error(error):
                DispatchQueue.main.async {
                    failure?(error)
                }
            }
        }
    }
    
    public func asyncSetObject(_ data: Data, forKey: CacheKey, completion: (() -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        self.storage?.async.setObject(data, forKey: forKey.rawValue, completion: { result in
            switch result {
            case .value:
                DispatchQueue.main.async {
                    completion?()
                }
            case let .error(error):
                DispatchQueue.main.async {
                    failure?(error)
                }
            }
        })
    }
    
    public func asyncObject<T: Codable>(forKey: CacheKey, type: T.Type, completion: @escaping ((T) -> Void), failure: ((Error) -> Void)? = nil) {
        self.asyncObject(forKey: forKey, completion: { [weak self] data in
            guard let `self` = self else { return }
            self.storage?.async.serialQueue.async {
                let result = CacheSerializer.formData(data: data, type: type)
                DispatchQueue.main.async {
                    completion(result)
                }
            }
        }, failure: failure)
    }
    
    public func asyncSetObject(_ object: Codable, forKey: CacheKey, completion: (() -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        self.storage?.async.serialQueue.async {
            let data = CacheSerializer.toData(object: object)
            self.asyncSetObject(data, forKey: forKey, completion: completion, failure: failure)
        }
    }
    
    public func asyncRemoveObject(forKey: CacheKey, completion: (() -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        self.storage?.async.removeObject(forKey: forKey.rawValue) { result in
            switch result {
            case .value:
                DispatchQueue.main.async {
                    completion?()
                }
            case let .error(error):
                DispatchQueue.main.async {
                    failure?(error)
                }
            }
        }
    }
    
    public func asyncRemoveAll(completion: (() -> Void)? = nil, failure: ((Error) -> Void)? = nil) {
        self.storage?.async.removeAll { result in
            switch result {
            case .value:
                DispatchQueue.main.async {
                    completion?()
                }
            case let .error(error):
                DispatchQueue.main.async {
                    failure?(error)
                }
            }
        }
    }
    
    public func asyncExistsObject(forKey: CacheKey, completion: ((Bool) -> Void)? = nil) {
        self.storage?.async.existsObject(forKey: forKey.rawValue) { result in
            switch result {
            case .value(_):
                DispatchQueue.main.async {
                    completion?(true)
                }
            case .error(_):
                DispatchQueue.main.async {
                    completion?(false)
                }
            }
        }
    }
}
