//
//  LoginViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var tetAccount: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 1{
            
            textField.resignFirstResponder()
            
            self.txtPassword.becomeFirstResponder()
            
        } else{
            
            textField.resignFirstResponder()
            
            self.btnLogin.isEnabled = true
            
            
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let accept = "abcdedf1234567890"
        
        //inverted 从不与你最初指定的字符匹配的集合中删除所有字符属性
        let cs = NSCharacterSet(charactersIn: accept).inverted
        
        let filtered = string.components(separatedBy: cs).joined(separator: "")
        
        if string != filtered{
            
            return false
        }
        
        var maxLength :Int = 0
        
        if textField.tag == 1{
            
            maxLength = 8
            
        } else{
            
            maxLength = 6
            
        }
        
        let currentString: NSString = textField.text! as NSString
        
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        
        return newString.length <= maxLength
    }
    
    @IBAction func login(_ sender: Any) {
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
