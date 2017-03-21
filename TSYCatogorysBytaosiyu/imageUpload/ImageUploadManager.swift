//
//  ImageUploadManager.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/13.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

class ImageUploadManager: NSObject {
    
    lazy var queue = OperationQueue()
    
    lazy var operationCache = [String:ImageUploadOperation]()
    
    static func sharedManager()->ImageUploadManager{
        struct share {
            static let manager = ImageUploadManager()
        }
        return share.manager
    }
    
    //全局管理
    func uploadWithURLString(urlString:String,index:Int,success:@escaping ((Int)->())){
        if self.operationCache[urlString] != nil {
            return
        }
        
        //上传图片
        let op = ImageUploadOperation.uploaderOperationWithURLString(index: index, urlString: urlString) { (num) in
            success(index)
            
            self.operationCache.removeValue(forKey: urlString)
        }
        
        self.queue.addOperation(op)
        
        self.operationCache[urlString] = op
        
    }
    
    func cancelOperation(urlString:String){
        if urlString=="" {
            return;
        }
        self.operationCache[urlString]?.cancel()
        self.operationCache.removeValue(forKey: urlString)
        
    }

}
