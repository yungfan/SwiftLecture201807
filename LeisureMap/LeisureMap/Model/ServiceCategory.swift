//
//  ServiceCategory.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/27.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

// 实现Codable协议 属性与JSON对应
struct ServiceCategory: Codable {
    
    var name: String //类别名称
    
    var imagePath: String //图片
        
    var index: Int = 0 //索引

    
    init(name: String, imagePath:String, index:Int) {
      
        self.name = name
        
        self.imagePath = imagePath
        
        self.index = index
        
    }
    
  
}
