//
//  MasterViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Master"
        
        //初始化数据库工具类并完成创表等动作
        let sqliteWorker = SQLiteWorker()
        
        let categories: [ServiceCategory] = sqliteWorker.readData()
        
        print(categories.count)
        
        print("\(#file):\(#line):\(#function)")
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
