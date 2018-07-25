//
//  ViewController.swift
//  Lecture01
//
//  Created by stu1 on 2018/7/20.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - 隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    //MARK: - 改变状态栏的颜色
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
        
    }
    
}

