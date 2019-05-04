//
//  WebViewController.swift
//  NativeKit
//
//  Created by Zhilei Zheng on 5/4/19.
//  Copyright © 2019 Zhilei Zheng. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    

    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}

extension WebViewController: WKUIDelegate {
    
}
