//
//  RainSQLiteManager.swift
//  TSYCatogorysBytaosiyu
//
//  Created by peachRain on 2017/3/15.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit


/// SQLite管理工具为了方便的使用sqlite，超小型的，只是提供基本的功能(可以好难啊)
class RainSQLiteManager: NSObject {
    
    //获取管理对象
    static let shared:RainSQLiteManager = {
        struct Static{
            static let instance = RainSQLiteManager()
        }
        return Static.instance
    }()
    
    

}
