//
//  UserDeafult+extension.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/15.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

//这里可以自定义存储key
extension UserDefaults {
    
    /*! 关于账号的信息 Key 都放在这里 */
    struct Account: UserDefaultStoreTable {
        enum UserDefaultKey : String {
            case name
            case age
            case birth
        }
    }
    
    /*! 关于登陆情况 Key 都放在这里 */
    struct LoginStatus: UserDefaultStoreTable {
        enum UserDefaultKey:String {
            case lastLoginTime
            case sessionTime
        }
    }
}
