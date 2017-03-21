//
//  RainSQLiteFunc.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/20.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

@objc
class RainSQLiteFunc: NSObject {
    
    required override init() {
        super.init()
    }
    
    func ignoredKeys() -> [String] {
        return []
    }
    func primaryKey() -> String {
        return "id"
    }
    
    //MARK:=====================>
    /// 获取指定数量条件的数据
    ///
    /// - Parameters:
    ///   - filter: 筛选条件
    ///   - order: 排序
    ///   - limit: 获取数量
    /// - Returns: 返回数据对象
    class func getRows(tableName:String,filter:String="", order:String="", limit:Int=0) -> [RainSQLiteFunc] {
        var sql = "SELECT * FROM \(tableName))"
        if !filter.isEmpty {
            sql += " WHERE \(filter)"
        }
        if !order.isEmpty {
            sql += " ORDER BY \(order)"
        }
        if limit > 0 {
            sql += " LIMIT 0, \(limit)"
        }
        return self.rowsFor(tableName: tableName, sql: sql)
    }
    
    /// 通过id来获取数据
    ///
    /// - Parameters:
    ///   - id: 数据的id
    ///   - tableName: 表格名字
    /// - Returns: 返回对象
    class func getRowBy(id:Any,tableName:String) -> RainSQLiteFunc? {
        let row = self.init()
        let data = row.values()
        let db = RainSQLiteDB.shared
        var val = "\(id)"
        if id is String {
            val = "'\(id)'"
        }
        let sql = "SELECT * FROM \(tableName) WHERE \(row.primaryKey())=\(val)"
        let arr = db.query(sql:sql)
        if arr.count == 0 {
            return nil
        }
        for (key, _) in data {
            if let val = arr[0][key] {
                row.setValue(val, forKey:key)
            }
        }
        return row
    }
    
    
    /// 获取数量按条件
    ///
    /// - Parameter filter: 筛选条件
    /// - Returns: 还会数量
    class func count(filter:String="",tableName:String) -> Int {
        let db = RainSQLiteDB.shared
        var sql = "SELECT COUNT(*) AS count FROM \(tableName)"
        if !filter.isEmpty {
            sql += " WHERE \(filter)"
        }
        let arr = db.query(sql:sql)
        if arr.count == 0 {
            return 0
        }
        if let val = arr[0]["count"] as? Int {
            return val
        }
        return 0
    }
    
    
    /// 移除数据
    ///
    /// - Parameter filter: 筛选条件，可以为空
    /// - Returns: 返回成功与否
    class func remove(filter:String = "",tableName:String) -> Bool {
        let db = RainSQLiteDB.shared
        let sql:String
        if filter.isEmpty {
            sql = "DELETE FROM \(tableName)"
        } else {
            sql = "DELETE FROM \(tableName) WHERE \(filter)"
        }
        let rc = db.execute(sql:sql)
        return (rc != 0)
    }
    
    class func rowsFor(tableName:String,sql:String="") -> [RainSQLiteFunc] {
        var res = [RainSQLiteFunc]()
        let tmp = self.init()
        let data = tmp.values()
        let db = RainSQLiteDB.shared
        let fsql = sql.isEmpty ? "SELECT * FROM \(tableName)" : sql
        let arr = db.query(sql:fsql)
        for row in arr {
            let t = self.init()
            for (key, _) in data {
                if let val = row[key] {
                    t.setValue(val, forKey:key)
                }
            }
            res.append(t)
        }
        return res
    }
    
    
    /// 保存数据
    ///
    /// - Returns: nil
    func save(tableName:String)->Int{
        let db = RainSQLiteDB.shared
        let key = primaryKey()
        let data = values() //获取属性值
        var insert = true
        if let rid = data[key] {
            var val = "\(rid)"
            if rid is String {
                val = "'\(rid)'"
            }
            let sql = "SELECT COUNT(*) AS count FROM \(tableName) WHERE \(primaryKey())=\(val)"
            let arr = db.query(sql:sql)
            if arr.count == 1 {
                if let cnt = arr[0]["count"] as? Int {
                    insert = (cnt == 0)
                }
            }
        }
        let (sql, params) = getSQL(tableName: tableName, data: data, forInsert: insert)
        let rc = db.execute(sql:sql, parameters:params)
        if rc == 0 {
            NSLog("Error saving record!")
            return 0
        }
        let pid = data[key]
        if insert {
            if pid is Int64 {
                setValue(rc, forKey:key)
            } else if pid is Int {
                setValue(Int(rc), forKey:key)
            }
        }
        return rc
        
    }
    
    private func getSQL(tableName:String,data:[String:Any], forInsert:Bool = true) -> (String, [Any]?) {
        var sql = ""
        var params:[Any]? = nil
        if forInsert {
            sql = "INSERT INTO \(tableName)("
        } else {
            sql = "UPDATE \(tableName) SET "
        }
        let pkey = primaryKey()
        var wsql = ""
        var rid:Any?
        var first = true
        for (key, val) in data {
            if pkey == key {
                if forInsert {
                    if val is Int && (val as! Int) == -1 {
                        continue
                    }
                } else {
                    wsql += " WHERE " + key + " = ?"
                    rid = val
                    continue
                }
            }
            if first && params == nil {
                params = [AnyObject]()
            }
            if forInsert {
                sql += first ? "\(key)" : ", \(key)"
                wsql += first ? " VALUES (?" : ", ?"
                params!.append(val)
            } else {
                sql += first ? "\(key) = ?" : ", \(key) = ?"
                params!.append(val)
            }
            first = false
        }
        if forInsert {
            sql += ")" + wsql + ")"
        } else if params != nil && !wsql.isEmpty {
            sql += wsql
            params!.append(rid!)
        }
        return (sql, params)
    }
    
    
    //MARK:=====================<
    
    private func values() -> [String:Any] {
        var res = [String:Any]()
        let obj = Mirror(reflecting:self)
        for (_, attr) in obj.children.enumerated() {
            if let name = attr.label {
                if ignoredKeys().contains(name) || name.hasSuffix(".storage") {
                    continue
                }
                res[name] = get(value:attr.value)
            }
        }
        return res
    }
    
    private func get(value:Any) -> Any {
        if value is String {
            return value as! String
        } else if value is Int {
            return value as! Int
        } else if value is Float {
            return value as! Float
        } else if value is Double {
            return value as! Double
        } else if value is Bool {
            return value as! Bool
        } else if value is Date {
            return value as! Date
        } else if value is NSData {
            return value as! NSData
        }
        return ""
    }

}
