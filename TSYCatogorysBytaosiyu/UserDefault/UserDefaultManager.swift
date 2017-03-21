//
//  UserDefaultManager.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/15.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

class UserDefaultManager: NSObject {
    
    let TSY = UserDefaults.standard
    
    private override init(){}

}

//构建方法
protocol UserDefaultNameSpace { }

extension UserDefaultNameSpace {
    static func namespace<T>(_ key:T) -> String where T :RawRepresentable {
        return "\(Self.self).\(key.rawValue) "
    }
}

protocol UserDefaultStoreTable:UserDefaultNameSpace {
    associatedtype UserDefaultKey : RawRepresentable
}

extension UserDefaultStoreTable where UserDefaultKey.RawValue == String {}

extension UserDefaultStoreTable {
    
    static func set(value:Int, forKey key:UserDefaultKey){
        let key = namespace(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func integer(forKey key:UserDefaultKey) -> Int {
        let key = namespace(key)
        return UserDefaults.standard.integer(forKey: key)
    }
    
    /// 关于 String 类型存储和读取
    static func set(value:Any?, forKey key:UserDefaultKey){
        let key = namespace(key)
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func string(forKey key:UserDefaultKey) -> String? {
        let key = namespace(key)
        return UserDefaults.standard.string(forKey: key)
    }
}




