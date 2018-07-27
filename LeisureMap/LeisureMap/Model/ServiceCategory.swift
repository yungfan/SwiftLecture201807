//
//  ServiceCategory.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class ServiceCategory {
    
    var Name: String?
    
    var ImagePath: String?
        
    var Index: Int = 0
    
    
    init(name: String, imagePath:String, index:Int) {
      
        Name = name
        
        ImagePath = imagePath
        
        Index = index
        
    }
    
  
}
