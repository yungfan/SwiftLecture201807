//
//  NoteViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit

class NoteViewController: UIViewController {

    @IBOutlet weak var noteWebView: UIWebView!
    
    
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Note"
        
        let url = URL(string: urlString!)
        
        let request = URLRequest(url: url!)
        
        self.noteWebView.loadRequest(request)
      
    }
    

}
