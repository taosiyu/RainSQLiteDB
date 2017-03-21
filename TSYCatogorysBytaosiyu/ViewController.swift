//
//  ViewController.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/13.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit
import Contacts

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc = UIView.begin().eh(40).ew(50).ex(5).ey(6).color(0x000000)
        
        self.view.addSubview(vc)
        
        
        RainSQLiteDB.shared.createTable(sqlParam: "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,username TEXT NOT NULL, password TEXT NOT NULL,email TEXT NOT NULL,age INTEGER", tableName:"firstTab")
        let dic = ["username":"hahaha","password":"121212","email":"fafsa@qqq.com","age":18] as [String : Any]
//        RainSQLiteDB.shared.addInfo(paramArray: nil, paramDic: dic, tableName: "firstTab")
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
