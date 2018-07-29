//
//  LeisureMapTests.swift
//  LeisureMapTests
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import XCTest
@testable import LeisureMap

class LeisureMapTests: XCTestCase {
    
    var sqliteWork : SQLiteWorker?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    
        sqliteWork = SQLiteWorker()
        
        sqliteWork?.createDatabase()
    
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        sqliteWork?.clearAll()
    }
    
    
    //Xcode导航栏 第6个按钮 中有这些方法 点击就可以进行测试
    func testInsert(){
        
        sqliteWork?.insertData(_id: 1, _name: "AAA", _imagepath: "BBB")
        
        let value = sqliteWork?.readData()
        
        XCTAssert(value?.count == 1, "pass")
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
       
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            
            sqliteWork?.insertData(_id: 1, _name: "AAA", _imagepath: "BBB")
            
            _ = sqliteWork?.readData()
        }
    }
    
}
