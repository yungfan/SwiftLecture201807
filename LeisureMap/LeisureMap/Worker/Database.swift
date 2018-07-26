//
//  Database.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/26.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

import Foundation
import SQLite

struct Database {
    
    var db: Connection!
    
    init() {
        connectDatabase()
    }
    
    // 与数据库建立连接
    mutating func connectDatabase(filePath: String = "/Documents") -> Void {
        
        let sqlFilePath = NSHomeDirectory() + filePath + "/db.sqlite3"
        
        do { // 与数据库建立连接
            db = try Connection(sqlFilePath)
            
            print("与数据库建立连接 成功")
            
        } catch {
            
            print("与数据库建立连接 失败：\(error)")
            
        }
        
    }
    
    let TABLE_USER = Table("table_user") // 表名称
    let TABLE_USER_ID = Expression<Int64>("user_id") // 列表项及项类型
    let TABLE_USER_NAME = Expression<String>("user_name")
    let TABLE_USER_PASSWORD = Expression<String>("user_password")

    
    // 建表
    func tableUserCreate() -> Void {
        do { // 创建表TABLE_USER
            
            try db.run(TABLE_USER.create { table in
                
                table.column(TABLE_USER_ID, primaryKey: .autoincrement) // 主键自加且不为空
                
                table.column(TABLE_USER_NAME)
                
                table.column(TABLE_USER_PASSWORD)
            })
            
            print("创建表 TABLE_USER 成功")
        
        } catch {
            
            print("创建表 TABLE_USER 失败：\(error)")
        
        }
    }
    
    // 插入
    func userInsert(name: String, pwd: String) -> Void {
        let insert = TABLE_USER.insert(TABLE_USER_NAME <- name, TABLE_USER_PASSWORD <- pwd)
        
        do {
            
            let rowid = try db.run(insert)
            
            print("插入数据成功 id: \(rowid)")
            
        } catch {
            
            print("插入数据失败: \(error)")
        }
    }

    
    // 读取
    func userQuery(name: String, pwd: String) -> Bool {
          
       let user:AnySequence<Row>? = try! db.prepare(TABLE_USER.filter(TABLE_USER_NAME == name))
    
       if user == nil{
    
            return false
        }
        
       else{
        
            return true
        }
    }
    
}
