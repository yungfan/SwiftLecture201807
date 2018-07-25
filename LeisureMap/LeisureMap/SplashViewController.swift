//
//  SplashViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/23.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var version: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let userDefaults = UserDefaults.standard
        
        let url:URL = URL(string:"https://score.azurewebsites.net/api/version/1")!
    
        let session: URLSession = URLSession()
            
        userDefaults.synchronize()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
