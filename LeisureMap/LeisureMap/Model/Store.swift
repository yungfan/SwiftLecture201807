//
//  Store.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class Store {
    
    var ServiceIndex: Int = 0
    
    var Name: String?
    
    var Location: LocationDesc?
    
    var Index: Int = 0
    
    var ImagePath: String?
    
    init(serviceIndex: Int, name: String, location:LocationDesc, imagePath:String, index:Int) {
        
        ServiceIndex = serviceIndex
        
        Location = location
        
        Name = name
        
        ImagePath = imagePath
        
        Index = index
        
    }
 
}

class LocationDesc{
    
    var Address: String?  //地址
    
    var Latitude: Double? //纬度
    
    var Longitude: Double?  //经度
    
    init(address: String, latitude:Double, longitude:Double) {
        
        Address = address
        
        Latitude = latitude
        
        Longitude = longitude
        
    }
    
}
