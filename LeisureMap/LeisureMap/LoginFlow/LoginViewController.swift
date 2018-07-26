//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    //MARK: - @IBOutlet
    @IBOutlet weak var tetAccount: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    
    //MARK: - UITextFieldDelegate
    //按下键盘的 return 按钮执行的操作
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        //如果输入框是用户名
        if textField.tag == 1{
            
            //键盘收起来
            textField.resignFirstResponder()
            //光标移到密码输入框
            self.txtPassword.becomeFirstResponder()
            
        }
        
        //如果输入框是密码
        else{
             //键盘收起来
            textField.resignFirstResponder()
             //按钮可点击
            self.btnLogin.isEnabled = true
            
            
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //限制用户输入的字符集
        let accept = "qwertyuiopasdfghjklzxcvbnm1234567890_"
        
        //inverted 从不与你最初指定的字符匹配的集合中删除所有字符属性
        let cs = NSCharacterSet(charactersIn: accept).inverted
        
        //获取匹配的字符
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        
        //和你输入的单个字符比较，如果不一致不允许输入
        if string != filtered{
            
            return false
        }
        
        var maxLength :Int = 0
        
        //设置用户名输入的最大长度
        if textField.tag == 1{
            
            maxLength = 8
            
        }
        
        //设置密码输入的最大长度
        else{
            
            maxLength = 6
            
        }
        
        //获取输入框的内容
        let currentString: NSString = textField.text! as NSString
        //转换
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        //限定长度
        return newString.length <= maxLength
    }
    
    //MARK: -  @IBOutlet
    //登录按钮
    @IBAction func login(_ sender: Any) {
        
        
    }
    
}
