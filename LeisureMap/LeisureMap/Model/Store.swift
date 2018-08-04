//
//  Store.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

struct Store: Codable{
    
    var serviceIndex: Int = 0 //服务索引
    
    var name: String? //名称
    
    var location: LocationDesc? //地理资讯
    
    var index: Int = 0 //索引
    
    var imagePath: String?  //图片
    
    init(serviceIndex: Int, name: String, location:LocationDesc, imagePath:String, index:Int) {
        
        self.serviceIndex = serviceIndex
        
        self.location = location
        
        self.name = name
        
        self.imagePath = imagePath
        
        self.index = index
        
    }
 
}

struct LocationDesc :Codable{
    
    var address: String?  //地址
    
    var latitude: Double? //纬度
    
    var longitude: Double?  //经度
    
    init(address: String, latitude:Double, longitude:Double) {
        
        self.address = address
        
        self.latitude = latitude
        
        self.longitude = longitude
        
    }
    
}
