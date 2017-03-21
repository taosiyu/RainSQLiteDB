//
//  HeighLevelFunc.swift
//  PoliceTool
//
//  Created by ncm on 2017/3/9.
//  Copyright © 2017年 ncm. All rights reserved.
//

import Foundation
//重新定义<符号
fileprivate func < <T: Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

open class THINK {
    
    open class func at<T>(_ array: [T], indexes: Int...) -> [T] {
        return self.at(array, indexes: indexes)
    }
    
    //获取数组中特定位置元素的方法
    open class func at<T>(_ array: [T], indexes: [Int]) -> [T] {
        var result: [T] = []
        for index in indexes {
            result.append(array[index])
        }
        return result
    }
    //多数组去除重复
    open class func union<T: Hashable>(_ arrays: [T]...) -> [T] {
        var result: [T] = []
        for arr in arrays {
            result += arr
        }
        return self.uniq(result)
    }
    //但数组去除重复内容
    open class func uniq<T: Hashable>(_ array: [T]) -> [T] {
        var result: [T] = []
        var map: [T: Bool] = [T: Bool]()
        for elem in array {
            if map[elem] == .none {
                result.append(elem)
            }
            map[elem] = true
        }
        return result
    }
    
    open class func contains<T: Equatable>(_ array: [T], value: T) -> Bool {
        return array.contains(value)
    }
    open class func pull<T: Equatable>(_ array: [T], values: [T]) -> [T] {
        return array.filter { !self.contains(values, value: $0) }
    }
    //获取排除某元素的数组
    open class func without<T: Equatable>(_ array: [T], values: T...) -> [T] {
        return self.pull(array, values: values)
    }
    
    
    

}
