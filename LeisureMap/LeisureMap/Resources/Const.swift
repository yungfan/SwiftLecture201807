//
//  Const.swift
//  LeisureMap
//
//  Created by 杨帆 on 2018/8/7.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import Foundation

///数据库路径
let sqlFilePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/db.sqlite3"

//服务器API
let baseURL = "https://score.azurewebsites.net/api/"


// 操作时间间隔
var pastTimesDict:[String:Int] = [:]
/// 判断是否满足间隔操作
///
/// - Parameters:
///     - keyName: 当前操作名字
///     - s: 间隔秒数
/// - Returns: true 可操作  false 未到时间
func afterTimes(_ keyName:String, s:Int) -> Bool {
    
    let now = NSDate()
    
    let timeInterval:TimeInterval = now.timeIntervalSince1970
    
    let timeStamp = Int(timeInterval)
    
    if let pastTime = pastTimesDict[keyName] {
        
        if timeStamp - pastTime > s {
            
            pastTimesDict[keyName] = timeStamp
            
            return true
            
        } else {
            
            return false
            
        }
    } else {
        
        pastTimesDict[keyName] = timeStamp
        
        return true
    }
}

