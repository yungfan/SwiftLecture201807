//
//  ViewController.swift
//  Lecture03
//
//  Created by stu1 on 2018/7/22.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //@IBOutlet关联的是View
    //UILabel
    @IBOutlet weak var lbName: UILabel!
    //UIView
    @IBOutlet weak var touchView: UIView!
    //UISlider
    @IBOutlet weak var slider: UISlider!
    //UIStepper
    @IBOutlet weak var stepper: UIStepper!
    //记录Silder的初始值
    var initValue:Float?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取Silder的初始值
        self.initValue = self.slider.value
    }
    
    //UIButton的点击事件
    //@IBAction关联的是Action
    //Any：任意类型，但是我们是知道这里是UIButton，所以可以进行类型转换
    @IBAction func btnClick(_ sender: Any) {
        
        //修改UILabel的文本
        lbName.text = "====🐶🐱🐭🐹🐰🐻🐼🐨🐯🐮🐷===="
        
        //as!类型转换
        let button = sender as! UIButton
        
        //设置UIButton的文本，UIButton是有状态的，需要明确告诉它改变的是什么状态下的文本
        button.setTitle("emoji", for: UIControl.State.normal)
        
    }
    
    
    //UISwitch的变化事件
    @IBAction func switchChanged(_ sender: Any) {
        
        let switchB = sender as! UISwitch
        
        print(switchB.isOn)
    }
    
    
    //UIStepper的变化事件
    @IBAction func stepperChanged(_ sender: Any) {

        self.slider.value = self.initValue! + Float(self.stepper.value)

    }
    
    //UISlider的变化事件
    @IBAction func sliderChanged(_ sender: Any) {
        
        let doubleValue = self.slider.value
        
        print(doubleValue)
        
    }
    
    //触摸开始方法
    //一根或者多根手指开始触摸view（手指按下)
    //UITouch: 当用一根手指触摸屏幕时，会创建一个与手指相关联的UITouch对象，它保存着跟本次手指触摸相关的信息，比如触摸的位置、时间。
    //event:每产生一个事件，就会产生一个UIEvent对象，UIEvent保存产生的事件和类型。
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        print("touchesBegan")
        
        //取出touches集合中的第一个元素
        if let touch = touches.first{
            //获取手指触摸的位置，in：参考坐标系，此处为控制器的view
            let loc = touch.location(in: self.view)
            
            print(loc)
            
            //判断触摸的点是不是在touchView范围内
            //如果上面获取的手指的触摸位置的参考系为touchView，下面的frame应该改为bounds
            if self.touchView.frame.contains(loc){

                //如果在范围内，就改成红色背景
                self.touchView.backgroundColor = UIColor.red
                
            }
            
            else{
                
                 //如果不在范围内，就改成蓝色背景
                 self.touchView.backgroundColor = UIColor.blue
                
            }
            
        }
    }
    
    //触摸结束方法
    //一根或者多根手指离开view（手指抬起）
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        print("touchesEnded")
    }
}

