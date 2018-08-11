//
//  NetWork.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/26.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import Foundation


//MARK: - 定义协议
protocol AsyncResponseDelegate: class{
    
    func receivedResponse(_ sender:AsyncRequestWorker, responseData:Data?, tag:Int)
    
}

//MARK: - 网络工具类
class AsyncRequestWorker {
    
    //weak或unowned 修饰代理时 会一个协议报错
    
    //解决办法1、可以将代理加上@objc的前缀，表示boject-c类型的协议而且好处是，协议中的方法不一定全部都要实现
    //解决办法2、直接在协议名后写：class
    
    weak var responseDelegate: AsyncResponseDelegate?
    
    //MARK: - 网络请求
    //from：网络请求的地址
    //tag：区分不同的网络请求任务
    func getResponse(from:String, tag:Int) {

        //1.创建URL
        let url:URL = URL(string:from)!
        
        //2.创建Session
        let session: URLSession = URLSession.shared
        
        //3.创建dataTask完成请求的任务，网络请求完成以后会回调闭包
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data, response, error) in
            
            //guard let 当error值为空时执行
            guard let error =  error else{
                
                //URLResponse转换成HTTPURLResponse
                let httpResponse = response as! HTTPURLResponse
                //获取响应状态码
                let statusCode = httpResponse.statusCode
                
                //状态码为200
                if statusCode == 200 {
                    
                    //将返回的data转成String
                    let responseResult = String(data: data!, encoding: String.Encoding.utf8)
                    
                    print("tag为\(tag)的网络请求Server返回的数据：\(responseResult!)")
               
                    //将返回的数据交给代理去完成，至于谁是代理，就看谁实现了AsyncResponseDelegate协议
                    self.responseDelegate?.receivedResponse(self, responseData: data!, tag: tag)
                }
                
                
                return
            }
            
            //代码运行至此，表示error一定有值
            print("\(error)")
            
        }
        
        //4.启动任务
        dataTask.resume()
        
    }
    
}
