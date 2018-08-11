//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    //MARK: - @IBOutlet
    @IBOutlet weak var txtAccount: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    var requestWorker:AsyncRequestWorker?  //网络工具类
    
    var fileWorker:FileWorker? //文件工具类
    
    let storeFileName:String = "store.json" //存储到沙盒的StoreJSON的文件名
    
    
    //MARK: - UIViewController LifeCircle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //创建工具类
        self.requestWorker = AsyncRequestWorker()
        
        self.fileWorker = FileWorker()
        
        //让当前的UIViewController成为代理，因为工具类返回的结果需要由它来处理，处理的方法就是协议中的方法
        self.requestWorker?.responseDelegate = self
        
        self.fileWorker?.fileWorkDelegate = self

    }
    
    
    //MARK: -  @IBAction
    //Login按钮
    @IBAction func login(_ sender: Any) {
        
        self.view .endEditing(true)
        
        //超过10分钟才再次请求网络 避免重复进行网络请求、数据库读写
        if afterTimes("login", s: 10*60) {
            //获取用户输入的信息
            let account = self.txtAccount.text!
            
            let password = self.txtPassword.text!
            
            if account.count > 0, password.count > 0{
                
                let url = baseURL + "login/\(account)/\(password)"
                
                //让网络工具类去完成请求
                self.requestWorker?.getResponse(from: url, tag: 2)
                
            }
        }
        
        else{
        
            self.performSegue(withIdentifier:"moveToMasterViewSegue", sender: self)
        }
       

    }
    
    //MARK: -  获取Category数据
    fileprivate func getCategory(){
        
        let url = baseURL + "servicecategory"
        
        self.requestWorker?.getResponse(from: url, tag: 3)
        
    }
    
    //MARK: -  获取Store数据
    fileprivate func getStore(){

        let url = baseURL + "store"
        
        self.requestWorker?.getResponse(from: url, tag: 4)
        
        
    }
    
    
    //MARK: - UserDefaults保存信息
    fileprivate func saveInfo(obj:String) {
        
        //获取用户设置
        let userDefaults = UserDefaults.standard
        
        //存储返回的JSON信息
        userDefaults.setValue(obj, forKey:"userAccount")
        
        //将数据同步缓存
        userDefaults.synchronize()
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    deinit {
        print("LoginViewController deinit")
    }
    
}

extension LoginViewController: UITextFieldDelegate, AsyncResponseDelegate, FileWorkerDelegate{
    
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
    
    //MARK: - AsyncResponseDelegate
    func receivedResponse(_ sender: AsyncRequestWorker, responseData: Data? , tag: Int) {
        
        guard let data = responseData else{
            
            return
        }
        
        switch tag {
            
            //login
            case 2:
           
                //login成功后获取Category
                getCategory()
            //category
            case 3:
                
                //利用JSONDecoder进行JSON到模型的转换
                let decoder = JSONDecoder()
                //直接转成数组对象
                guard let serviceCategories = try? decoder.decode([ServiceCategory].self, from: data) else{

                    return
                }
                
                //初始化数据库工具类并完成创表等动作
                let sqliteWorker = SQLiteWorker()
                sqliteWorker.createdTable()

                //循环插入数据库
                for serviceCategory in serviceCategories {
                    
                    sqliteWorker.insertData(_index:serviceCategory.index, _name: serviceCategory.name, _imagepath: serviceCategory.imagePath)
                }
                
                //获取Category后获取Store
                getStore()
            
            //store
            case 4:
                
                let responseString = String(data: data, encoding: String.Encoding.utf8)
                
                self.fileWorker?.writeToFile(content: responseString!, fileName: storeFileName, tag: tag)
            
   
            default:
            
                print("error")
        }
    }
    
    
    //MARK: - FileWorkerDelegate
    func filewWorkWriteCompleted(_ sender: FileWorker, fileName: String, tag: Int) {
        
        //print(fileName)

        DispatchQueue.main.async {
            
            self.performSegue(withIdentifier:"moveToMasterViewSegue", sender: self)
            
        }

    }
}
