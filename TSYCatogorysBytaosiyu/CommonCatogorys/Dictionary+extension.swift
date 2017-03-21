//
//  Dictionary+extension.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/13.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

extension Dictionary{
    //重写下标保证获取是安全的
    subscript (safe key: Key) -> Value? {
        get {
            return self[key]
        }
        set {
            if "\(newValue)" != "Optional(nil)" && "\(newValue)" != "Optional(\"nil\")" {
                self[key] = newValue
            } else {
                self[key] = nil
            }
        }
    }
}
