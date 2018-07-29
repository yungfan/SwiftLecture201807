//
//  LeisureMapUITests.swift
//  LeisureMapUITests
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import XCTest

class LeisureMapUITests: XCTestCase {
    
    
    //setup程序启动时会进入该方法
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    //tearDown程序结束时会进入该方法
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    //tearExmple测试方法，该方法系统生成，用于示例，我们可以自己写一些其他的方法，但是需要test打头，这样系统会识别出该方法为测试方法。
    //左侧有一个播放小图标，点击该图标程序会执行该测试方法。当遇到问题或者没有达到预期值得时候，方法后面会出现红色，方法通过之后会出现绿色。
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        //在该方法体内按下下面的红色按钮进行录制 录制完成以后 再次播放 观察执行
    }
    
    
}
