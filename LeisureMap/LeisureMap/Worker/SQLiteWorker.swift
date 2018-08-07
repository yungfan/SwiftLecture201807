//
//  SQLiteWorker.swift
//  LeisureMap
//
//  Created by 杨帆 on 2018/8/7.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import Foundation
import UIKit
import SQLite


struct SQLiteWorker {
    
    private var db: Connection!
    private let categories = Table("servicecategory") //表名
    private let id = Expression<Int>("id") //id
    private let index = Expression<Int>("index") //index
    private let name = Expression<String>("name") //name
    private let imagepath = Expression<String>("imagepath") //imagePath
    
    //MARK: - 构造函数
    init() {
        
        do {
            db = try Connection(sqlFilePath)
            print("与数据库建立连接成功")
            
        } catch { print("与数据库建立连接 失败：\(error)") }
        
    }

    //MARK: - 创建表格，表若存在不会再次创建，直接进入catch
    func createdTable()  {
        
        do {
            
            try db.run(categories.create { t in
                t.column(id, primaryKey: true)
                t.column(index)
                t.column(name)
                t.column(imagepath)
            })
            
            print("创表成功")
            
        } catch { print("创表失败\(error)")  }
        
        self.clearData()
    }
    
    //MARK: - 删除表中的数据
    func clearData(){
        
        do{
            //统计数据行数 SELECT count(*) FROM "tableName"
            let count = try db.scalar(categories.count)
            
            if count > 0 {
                
                //try db.run(categories.drop())
                
                self.clearAll()
                
                print("清空已有数据")
                
            }
        } catch { print("(error)") }

    }
    
    //MARK: - 增加数据
    func insertData(_index: Int, _name: String, _imagepath: String){
        
        do {
            
            let insert = categories.insert(index <- _index,name <- _name, imagepath <- _imagepath)
            
            try db.run(insert)
            
            print("增加数据成功")
            
        } catch { print("insertData错误\(error)")  }
    }
    
    //MARK: - 查询数据
    func readData() -> [ServiceCategory] {
        
        //将查询的结果保存到数组备用
        var responseArray : [ServiceCategory] = []
        
        for category in try! db.prepare(categories) {
            
            let serviceCategory = ServiceCategory(name: category[name], imagePath: category[imagepath], index: category[index])
            
            responseArray.append(serviceCategory)
        }
        
        print("读取数据成功")
        
        //排序
        responseArray.sort(by: { $0.index < $1.index })
        
        return responseArray
    }
    
    //MARK: - 更新数据
    func updateData(serviceIndex: Int, old_name: String, new_name: String) {
        
        let currcategories = categories.filter(index == serviceIndex)
        
        do {
            
            try db.run(currcategories.update(name <- name.replace(old_name, with: new_name)))
            
        } catch { print("updateData错误\(error)")  }
        
        print("更新数据成功")
        
    }
    
    //MARK: - 根据Index删除数据
    func delData(currcategoryIndex: Int) {
        
        let currcategories = categories.filter(index == currcategoryIndex)
        
        do {
            
            try db.run(currcategories.delete())
            
        } catch { print("delData错误\(error)")  }
        
        print("删除数据成功")
    }
    
    //MARK: - 删除所有数据
    func clearAll()  {
        
        let categories = readData()
        
        var indexes : [Int] = []
        
        for category in categories{
            
            indexes.append(category.index)
        }
        
        for index in indexes{
            
            delData(currcategoryIndex:index )
        }
        
    }
}


