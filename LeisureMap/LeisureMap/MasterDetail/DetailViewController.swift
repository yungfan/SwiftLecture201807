//
//  DetailViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedStore: Store?

    //MARK: - UIViewController LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = selectedStore?.name
        
        print(selectedStore!)
       
    }
    

    //MARK: - Actions
    //跳转到Map
    @IBAction func btnMapClicked(_ sender: Any) {
        
         self.performSegue(withIdentifier: "moveToMapViewSegue", sender: self)
        
    }
    
    //跳转到Note
    @IBAction func btnWebClicked(_ sender: Any) {
        
        
         self.performSegue(withIdentifier: "moveToNoteViewSegue", sender: self)
        
    }
   
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //通过segue的identifier判断到底是跳转的哪根线
//        switch segue.identifier {
//            
//        case "moveToMapViewSegue":
//            
//            let mapViewController = segue.destination as! MapViewController
//            
//        default:
//            
//            print("error")
//        }
        
    }
    

}
