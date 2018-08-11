//
//  NoteViewController.swift
//  LeisureMap
//
//  Created by stu1 on 2018/7/25.
//  Copyright © 2018年 YungFan. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    var flagWKWebView: WKWebView?
    
    var selectedFlag: MapFlag?
    
    var userContentController = WKUserContentController()
    
    //MARK: - UIViewController LifeCircle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = selectedFlag?.discipline
        
        //let url = URL(string: selectedFlag!.urlString)
        
        //let request = URLRequest(url: url!)
        
       // self.flagWKWebView.load(request)
    
        if let url = Bundle.main.url(forResource: "sample_js", withExtension: "txt") {
            
            
            
            let data = try! Data(contentsOf: url)
            
            let jScript = String(data: data, encoding: .utf8)
            
            print(jScript!)
            
            let userScript = WKUserScript(source: jScript!, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
            
            userContentController.addUserScript(userScript)
            
            userContentController.add(self, name:"callbackHandler")
            
            let preferences =  WKPreferences()
            
            preferences.javaScriptEnabled = true
            
            let configuration = WKWebViewConfiguration()
            
            configuration.selectionGranularity = WKSelectionGranularity.character
            
            configuration.preferences = preferences
            
            configuration.userContentController = userContentController
            
            flagWKWebView = WKWebView(frame: self.view.bounds, configuration: configuration)
            
            flagWKWebView?.uiDelegate = self
            
            flagWKWebView?.navigationDelegate = self
            
            //这段话必须放在上面大段之后
            if let url = Bundle.main.url(forResource: "sample", withExtension: "html") {
                
                let request = URLRequest(url: url)
                
                flagWKWebView?.load(request)
            }
            
            self.view.addSubview(flagWKWebView!)
        }
        
      
    }
    
   
  
    //移除操作，防止内存泄漏
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        userContentController.removeScriptMessageHandler(forName: "callbackHandler")
    }
    
    deinit {
        
        print("WebViewController deinit")
    }
}

extension WebViewController: WKUIDelegate {
    
    
    
}

extension WebViewController: WKNavigationDelegate {
    
    //网页加载成功
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        //执行一个javascript方法
        webView.evaluateJavaScript("getelement();") { (any, error) in
            
            guard let error = error else{
                
                print(any as! String)
                
                return
            }
            
            print(error)
        }
        
    }
    
    
    
}

// MARK: - javascript执行时回调
extension WebViewController: WKScriptMessageHandler {
    
    //javascript想执行本地操作的时候回调
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        
         print("----\(#file):\(#line):\(#function)----")
        
        if message.name == "callbackHandler" {
            
            print(message.body)
        }
    }
    
    
    //javascript alert执行
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        completionHandler()
        
        let alertController = UIAlertController(title: "温馨提示", message: message, preferredStyle: .alert)
        
        let actionOK = UIAlertAction(title: "OK", style:.default) { (action) in
            
            alertController.dismiss(animated: true, completion: nil)
        }
        
        let actionCancle = UIAlertAction(title: "Cancel", style:.destructive) { (action) in
            
            alertController.dismiss(animated: true, completion: nil)
        }
        
        alertController.addAction(actionOK)
        
        alertController.addAction(actionCancle)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    //javascript prompt执行
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        
        let alertController = UIAlertController(title: prompt, message:  "Input Text", preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            
            textField.text = defaultText
        }
        
        let actionOK = UIAlertAction(title: "OK", style:.default) { (action) in
            
            completionHandler(alertController.textFields![0].text)
        }
        
        alertController.addAction(actionOK)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
}

