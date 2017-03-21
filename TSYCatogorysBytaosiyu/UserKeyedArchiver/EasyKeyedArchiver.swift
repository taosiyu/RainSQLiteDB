//
//  EasyKeyedArchiver.swift
//  TSYCatogorysBytaosiyu
//
//  Created by ncm on 2017/3/15.
//  Copyright © 2017年 ncm. All rights reserved.
//

import UIKit

private let localPath = "userAccount.data".appendDocument()

class EasyKeyedArchiver: NSObject {
    
    static let shared:EasyKeyedArchiver = {
        struct Static{
            static let instance = EasyKeyedArchiver()
        }
        return Static.instance
    }()
    
    private override init() {}
    
    func userArchiver<T:Encoded>(model:T){
        NSKeyedArchiver.archiveRootObject(model, toFile:localPath)
    }
    
    func userUnarchiver(){
        if (NSKeyedUnarchiver.unarchiveObject(withFile:localPath) != nil) {
            let model = NSKeyedUnarchiver.unarchiveObject(withFile:localPath)
            
        }
    }
}

struct Coordinate{
    let latitude: Double
    let longitude: Double
    
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class EncodableCoordinate: NSObject, NSCoding {
    
    var coordinate: Coordinate?
    
    init(coordinate: Coordinate?) {
        self.coordinate = coordinate
    }
    
    required init?(coder decoder: NSCoder) {
        guard
            let latitude = decoder.decodeObject(forKey: "latitude") as? Double,
            let longitude = decoder.decodeObject(forKey: "longitude") as? Double
            else { return nil }
        coordinate = Coordinate(latitude: latitude, longitude: longitude)
    }
    
    func encode(with encoder: NSCoder) {
        encoder.encode(coordinate?.latitude, forKey: "latitude")
        encoder.encode(coordinate?.longitude, forKey: "longitude")
    }
}

protocol Encoded {
    associatedtype Encoder: NSCoding
    
    var encoder: Encoder { get }
}

protocol Encodable {
    associatedtype Value
    
    var value: Value? { get }
}

extension EncodableCoordinate: Encodable {
    var value: Coordinate? {
        return coordinate
    }
}

extension Coordinate: Encoded {
    var encoder: EncodableCoordinate {
        return EncodableCoordinate(coordinate: self)
    }
}















