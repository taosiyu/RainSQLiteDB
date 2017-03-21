//
//  Array+extension.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/13.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

extension Array{
    
    subscript (safe index: Int) -> Element? {
        return (0 ..< count).contains(index) ? self[index] : nil
    }

    
}
