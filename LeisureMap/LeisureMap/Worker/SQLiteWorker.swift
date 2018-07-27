//
//  SQLiteWorker.swift
//  LeisureMap
//
//  Created by 房懷安 on 2018/7/25.
//  Copyright © 2018年 房懷安. All rights reserved.
//

import Foundation
import UIKit
import SQLite


struct SQLiteWorker {
    
    private var db: Connection!
    private let categories = Table("servicecategory") //表名
    private let id = Expression<Int>("id") //id
    private let name = Expression<String>("name") //name
    private let imagepath = Expression<String>("imagepath") //imagePath
    
     //MARK: - 构造函数
    init() {
        
        let sqlFilePath = NSHomeDirectory() + "/Documents/db.sqlite3"
        
        do {
            
            db = try Connection(sqlFilePath)
            print("与数据库建立连接成功")
            
        } catch { print("与数据库建立连接 失败：\(error)") }
        
        
        do {
            
            let count = try db.scalar(categories.count)
            print("init count:\(count)")
            
        } catch { print(error) }
    }
    
    
     //MARK: - 创建表格
    func createDatabase()  {
        createdTable()
    }
    
    private func createdTable()  {
        
        do{
            
            let count = try db.scalar(categories.count)
            
            if count > 0 {
                try db.run(categories.drop())
            }
        } catch { print(error) }
        
        do {

            try db.run(categories.create { t in
                t.column(id, primaryKey: true)
                t.column(name)
                t.column(imagepath)
            })
            
            print("创表成功")
            
        } catch { print("创表失败\(error)") }
        
        do {
            
            let count = try db.scalar(categories.count)
            
            print("createdTable count:\(count)")
            
        } catch { print(error) }
        
        
    }
    
     //MARK: - 增加数据
    func insertData(_name: String, _imagepath: String){
        
        do {
            
            let insert = categories.insert(name <- _name, imagepath <- _imagepath)
            
            try db.run(insert)
            
        } catch { print(error) }
    }
    
     //MARK: - 查询数据
    func readData() -> [ServiceCategory] {
        
        //将查询的结果保存到数组备用
        var responseArray : [ServiceCategory] = []
        
        for category in try! db.prepare(categories) {
            
            let serviceCategory = ServiceCategory(name: category[name], imagePath: category[imagepath], index: category[id])
            
            responseArray.append(serviceCategory)
        }
        
        //排序
        responseArray.sort(by: { $0.Index < $1.Index })
        
        return responseArray
    }
    
     //MARK: - 更新数据
    func updateData(serviceId: Int, old_name: String, new_name: String) {
        
        let currcategories = categories.filter(id == serviceId)
        
        do {
            
            try db.run(currcategories.update(name <- name.replace(old_name, with: new_name)))
            
        } catch { print(error) }
        
    }
    
     //MARK: - 根据ID删除数据
    func delData(currcategoryIndex: Int) {
        
        let currcategories = categories.filter(id == currcategoryIndex)
        
        do {
            
            try db.run(currcategories.delete())
            
        } catch { print(error) }
    }
    
     //MARK: - 删除所有数据
    func clearAll()  {
        
        let categories = readData()
        
        var indexes : [Int] = []
        
        for category in categories{
            
            indexes.append(category.Index)
        }
        
        for index in indexes{
            
            delData(currcategoryIndex:index )
        }
        
    }
}

