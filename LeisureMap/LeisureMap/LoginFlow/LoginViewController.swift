//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit
import SwiftyJSON

class LoginViewController: UIViewController, UITextFieldDelegate, AsyncResponseDelegate {

    
    
    //MARK: - @IBOutlet
    @IBOutlet weak var txtAccount: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    var requestWorker:AsyncRequestWorker?  //工具类

    var database: Database! //数据库
    
    
    //MARK: - UIViewController LifeCircle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //创建网络请求工具类
        self.requestWorker = AsyncRequestWorker()
        
        //让当前的UIViewController成为代理，因为工具类返回的结果需要由它来处理，处理的方法就是协议中的方法
        self.requestWorker?.responseDelegate = self

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
            //self.btnLogin.isEnabled = true
            
            
        }
        
        return true
    }
    
    //对输入的每个字符进行检测
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
    
    //MARK: -  @IBAction
    //Login按钮
    @IBAction func login(_ sender: Any) {
        
        self.view .endEditing(true)
        
        //获取用户输入的信息
        let account = self.txtAccount.text!
        
        let password = self.txtPassword.text!
        
        if account.count > 0, password.count > 0{
            
            let url = "https://score.azurewebsites.net/api/login/\(account)/\(password)"
            
            //让网络工具类去完成请求
            self.requestWorker?.getResponse(from: url, tag: 2)
            
        }

    }
    
    
    //MARK: - 保存信息
    fileprivate func saveInfo(obj:String) {
        
        //获取用户设置
        let userDefaults = UserDefaults.standard
        
        //存储返回的JSON信息
        userDefaults.setValue(obj, forKey:"userAccount")
        
        //将数据同步缓存
        userDefaults.synchronize()
    }
    
    //MARK: - AsyncResponseDelegate
    func receivedResponse(_ sender: AsyncRequestWorker, responseString: String, tag: Int) {
        
        print("Server返回的数据：\(responseString)")
        
        self.saveInfo(obj: responseString)
        //服务器JSON数据
        // {
        //    "Name" : "使用者一",
        //    "LoginContent" : "account:yf;password:123",
        //    "Phone" : "13213215895"
        // }
        //通过Swifty处理JSON数据
        let json = JSON(parseJSON: responseString)["LoginContent"].stringValue
        
        //获取LoginContent数据
        let loginContent = json.split(separator: ";")
        
        print(loginContent)
        
        //网络请求会自动开启一个新线程，而iOS中更新UI的操作必须在主线程
        DispatchQueue.main.async {
            //与数据库建立连接
            self.database = Database()
            
            //将用户名和密码存储到数据库
            self.database.userInsert(name: String(loginContent[0]), pwd: String(loginContent[1]))
            
            self.performSegue(withIdentifier:"moveToMasterViewSegue", sender: self)
       
        }
        
    }
    
    
}
