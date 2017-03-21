//
//  UIView+Easy.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/13.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

extension UIView{
    
    func X()->CGFloat{
        return self.frame.origin.x
    }
    func Y()->CGFloat{
        return self.frame.origin.y
    }
    func H()->CGFloat{
        return self.frame.size.height
    }
    func W()->CGFloat{
        return self.frame.size.width
    }
    func Center()->CGPoint{
        return self.center
    }
    func Size()->CGSize{
        return self.frame.size
    }
    
}

extension UIView{
    
    static func begin()->UIView{
        let vc = UIView()
        return vc
    }
    
    func es(_ h:CGFloat,_ w:CGFloat) -> UIView {
        self.eh(h).ew(w).end()
        return self
    }
    
    func ef(_ h:CGFloat,_ w:CGFloat,_ x:CGFloat,_ y:CGFloat)->UIView{
        self.eh(h).ew(w).ex(x).ey(y).end()
        return self
    }
    
    func eh(_ height:CGFloat)->UIView{
        self.frame.size.height = height
        return self
    }
    
    func ew(_ width:CGFloat)->UIView{
        self.frame.size.width = width
        return self
    }
    
    func ex(_ x:CGFloat)->UIView{
        self.frame.origin.x = x
        return self
    }
    
    func ey(_ y:CGFloat)->UIView{
        self.frame.origin.y = y
        return self
    }
    
    func color(_ colorInt:Int) -> UIView {
        self.backgroundColor = UIColor.rgbColor(rgbValue:colorInt)
        return self
    }
    
    func end(){
        
    }
}
