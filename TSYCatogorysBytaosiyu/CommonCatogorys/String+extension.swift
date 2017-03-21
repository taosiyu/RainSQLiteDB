//
//  String+extension.swift
//  TSYCatogorysBytaosiyu
//
//  Created by peachRain on 2017/3/13.
//  Copyright © 2017年 ncm. All rights reserved.
//

import Foundation
import UIKit

enum SliceType:Int{
    case Split = 1,VerLine,Comma,Star,Space,Point
    
    static func convert(rawValue:SliceType)->String{
        switch rawValue {
        case .Split:
            return ","
        case .VerLine:
            return "|"
        case .Comma:
            return "，"
        case .Star:
            return "*"
        case .Space:
            return " "
        case .Point:
            return "."
        }
    }
}

class SString {

    //合并数组->字符串
    open class func slice(array:[String],type:SliceType)->String?{
        return array.joined(separator: SliceType.convert(rawValue: type))
    }
}

extension String {
    //字符串长度
    var length:Int {return characters.count}
    
    //去除空格
    var trimedString: String {
        return trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    //去除全部空格
    var replacedSpaceString: String {
        return replacingOccurrences(of: " ", with: "")
    }
    //空就返回"" 不空就返回去除空格的内容
    func trimString() -> String {
        if String.isEmptyString(string: self as AnyObject?) {
            return ""
        }
        return self.trimedString
    }
    //字符串空就返还默认，有就返回原字符串
    func fixStr(placeHoloderStr: String) -> String {
        if self.isEmpty {
            return self
        }
        return placeHoloderStr
    }
    //有没有包含字符串
    func containsString(s:String) -> Bool
    {
        if(self.range(of: s) != nil)
        {
            return true
        }
        else
        {
            return false
        }
    }
    //反向字符串
    func reverse() -> String
    {
        var reverseString : String = ""
        for c in self.characters
        {
            reverseString = String(c) + reverseString
        }
        return reverseString
    }
    
    
    //字符串分解成数组按"."分
    var splitArr: [String] {
        if String.isEmptyString(string: self as AnyObject?) {
            return [String]()
        }
        return components(separatedBy: ".")
    }
    
    //判断是不是为空字符串
    func isEmpty() -> Bool {
        return  self.length <= 0 ? false: true
    }
    
    //判断是不是为空
    static func isEmptyString(string: AnyObject?) -> Bool {
        if let temp = string {
            if temp is NSNull {
                return false
            }
            if !(temp is String) {
                return false
            }
            return temp.trimmingCharacters(in: CharacterSet.whitespaces).isEmpty
        }
        return true
    }
    
    //NSRange转成Range
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from..<to
    }
    //Range换NSRange
    func NSRangeFromRange(range : Range<String.Index>) -> NSRange {
        let utf16view = self.utf16
        let from = String.UTF16View.Index(range.lowerBound, within: utf16view)
        let to = String.UTF16View.Index(range.upperBound, within: utf16view)
        return NSMakeRange(utf16view.startIndex.distance(to: from), from.distance(to: to))
    }
    
    //文字高度计算
    func heightWithConstrainedWidth(width:CGFloat, font: UIFont?) -> CGFloat {
        var ff = font
        if ff==nil {
            ff = UIFont.systemFont(ofSize: 13)
        }
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: ff!], context: nil)
        return boundingBox.height
    }
    //文字宽度计算
    func widthWithConstrainedHeight(height: CGFloat, font: UIFont?) -> CGFloat {
        var ff = font
        if ff==nil {
            ff = UIFont.systemFont(ofSize: 13)
        }
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName: ff!], context: nil)
        return boundingBox.width
    }
    
}

//MARK:获取沙盒的路劲
extension String{
    //字符串截取
    func substring(s: Int, _ e: Int? = nil) -> String {
        let start = s >= 0 ? self.startIndex : self.endIndex
        let startIndex = start
        var end: String.Index
        var endIndex: String.Index
        if(e == nil){
            end = self.endIndex
            endIndex = self.endIndex
        } else {
            end = e! >= 0 ? self.startIndex : self.endIndex
            endIndex = end
        }
        
        let range = Range<String.Index>(startIndex..<endIndex)
        return self.substring(with: range)
    }
    
    
    //MARK:沙盒
    func appendCache()->String{
        if let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last {
            let path = (filePath as NSString).appendingPathComponent(self)
            return path as String
        }
        return ""
    }
    
    func appendTemp()->String{
        let filePath = NSTemporaryDirectory()
        let path = (filePath as NSString).appendingPathComponent(self)
        return path as String
    }
    
    func appendDocument()->String{
        if let filePath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last {
            let path = (filePath as NSString).appendingPathComponent(self)
            return path as String
        }
        return ""
    }

}

//MARK:Code相关
extension String{

    func codeUTF8()->[CChar]{
        if self=="" || self==" " {
            return [CChar]()
        }
        return self.cString(using: String.Encoding.utf8)!
    }

}

















