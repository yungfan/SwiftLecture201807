//
//  FileWorker.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/26.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import Foundation


//MARK: - 定义协议
protocol FileWorkerDelegate{
    
    func filewWorkWriteCompleted(_ sender:FileWorker, fileName:String, tag:Int)
    
    func filewWorkReadCompleted(_ sender:FileWorker, fileName:String, tag:Int)
    
}

//MARK: - 文件工具类
class FileWorker {
    
    var fileWorkDelegate: FileWorkerDelegate?
    
    func writeToFile(content:String, fileName:String, tag:Int) {
        
        //找到沙盒的Documents目录
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            //拼接自己的文件名
            let fileURL = dir.appendingPathComponent(fileName)
            
            do {
                
                //写入文件
                try content.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                
                //交给Delegate处理
                self.fileWorkDelegate?.filewWorkWriteCompleted(self, fileName: fileURL.absoluteString, tag: tag)
                
                print("写入成功")
                
            } catch {
                
                print("写入失败：\(error)")
                
            }
        }
        
    }
    
    
    func readFromFile(fileName:String, tag:Int)  -> String{
        
         var result :String = ""
        //找到沙盒的Documents目录
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            //拼接自己的文件名
            let fileURL = dir.appendingPathComponent(fileName)
            
            do {
                
                //读取文件
                result =  try String(contentsOf: fileURL)
                
                //交给Delegate处理
                self.fileWorkDelegate?.filewWorkReadCompleted(self, fileName: fileURL.absoluteString, tag: tag)
                
                print(" 读取成功")
                
            } catch {
                
                print("读取失败：\(error)")
                
            }
        }
        
        return result
    }


}
