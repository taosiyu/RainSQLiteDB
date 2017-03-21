//
//  UIImageView+Cache.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/13.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

extension UIImageView{
    struct runtimeKey {
        static var key = "ImageCache"
    }
    //保存下载的地址
    var currentURLString: String? {
        set {
            objc_setAssociatedObject(self, runtimeKey.key, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return  objc_getAssociatedObject(self, runtimeKey.key) as? String
        }
    }
    
    func setImageUrlString(urlString:String){
        //判断当前点击的图片地址，和上一次图片的地址，是否一样，如果不一样，取消上一次操作
        if (urlString == self.currentURLString) {
            ImageUploadManager.sharedManager().cancelOperation(urlString: self.currentURLString!)
        }
        
        //记录当前点击图片的地址
        self.currentURLString = urlString;
        
        //上传图片

    
    
    }
    
}
