//
//  ImageUploadOperation.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/13.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

class ImageUploadOperation: Operation {
    
    var urlString:String = ""
    
    var index:Int = 0
    
    var finishClosure:((Int)->())!
    
    static func uploaderOperationWithURLString(index:Int,urlString:String,finishedClosure:@escaping ((Int)->()))->ImageUploadOperation{
        let operation = ImageUploadOperation.init()
        operation.urlString = urlString
        operation.index = index
        operation.finishClosure = finishedClosure
        return operation
    }
    
    override func main() {
        autoreleasepool {
            
            //上传图片
            //网络上传图片的任务放在这里
            
            //取消
            if (self.isCancelled) {
                return
            }
            print("上传成功图片\(self.urlString)=\(Thread.current)")
            
            OperationQueue.main.addOperation({ 
                self.finishClosure(self.index)
            })
            
        }
    }

}
