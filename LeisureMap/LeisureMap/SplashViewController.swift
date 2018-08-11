//
//  SplashViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    
    @IBOutlet weak var lbVersion: UILabel!
    
    var appVersion:String?   //版本号
    
    var requestWorker:AsyncRequestWorker?  //工具类
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //创建网络请求工具类
        self.requestWorker = AsyncRequestWorker()
        
        //让当前的UIViewController成为代理，因为工具类返回的结果需要由它来处理，处理的方法就是协议中的方法
        self.requestWorker?.responseDelegate = self
        
        //从info.plist中获取app版本号
        self.appVersion = "" + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
        
        //网络请求的url
        let url = baseURL + "version/\(self.appVersion!)"
        
        //让网络工具类去完成请求
        self.requestWorker?.getResponse(from: url, tag: 1)
    }
    
    
    // MARK: - UserDefaults保存信息
    fileprivate func saveInfo(obj:String) {
        
        //获取用户设置
        let userDefaults = UserDefaults.standard
        
        //存储版本信息
        userDefaults.setValue(obj, forKey:"serverVersion")
        
        //将数据同步缓存
        userDefaults.synchronize()
    }
    
    
    //界面跳转
    @objc fileprivate func moveToLoginViewSegue(){
        
        //withIdentifier：StoryBoard中设置的"连接线"的identifier
        self.performSegue(withIdentifier: "moveToLoginViewSegue", sender: self)
    }
    
    
    deinit {
        print("SplashViewController deinit")
    }
    
}


extension SplashViewController: AsyncResponseDelegate{
    
    // MARK: - 从服务器获取信息
    func receivedResponse(_ sender: AsyncRequestWorker, responseData: Data?, tag: Int) {
        
        guard let data = responseData else{
            
            return
        }
        
        let responseString = String(data: data, encoding: String.Encoding.utf8)
        
        self.saveInfo(obj: responseString!)
        
        //网络请求会自动开启一个新线程，而iOS中更新UI的操作必须在主线程，所以回到主线程去更新Label的文本和跳转
        DispatchQueue.main.async {
            //设置Label的文本
            self.lbVersion.text = responseString
            
            //1秒后跳转到下一个界面
            self.perform(#selector(self.moveToLoginViewSegue), with: nil, afterDelay: 2)
        }
        
        
    }
    
}
