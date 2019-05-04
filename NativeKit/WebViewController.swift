//
//  WebViewController.swift
//  NativeKit
//
//  Created by Zhilei Zheng on 5/4/19.
//  Copyright © 2019 Zhilei Zheng. All rights reserved.
//

import UIKit
import WebKit
import SnapKit
import NVActivityIndicatorView

class WebViewController: UIViewController {
    
    var script:Script?
    
    var loaded = false
    
    let webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: webConfiguration)
        return view
    }()
    
    let coverView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    let indicator = NVActivityIndicatorView(frame: .zero, type: .pacman, color: .red, padding: 20)
    
//    override func loadView() {
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.uiDelegate = self
//        webView.navigationDelegate = self
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        view.addSubview(coverView)
        coverView.addSubview(indicator)
        view.backgroundColor = .white
        if let url = script?.url {
            let myURL = URL(string: url)
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
        webView.snp.makeConstraints { (view) in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            view.left.equalToSuperview()
            view.right.equalToSuperview()
        }
        coverView.snp.makeConstraints { (view) in
            view.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            view.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            view.left.equalToSuperview()
            view.right.equalToSuperview()
        }
        indicator.snp.makeConstraints { (view) in
            view.centerX.centerY.equalToSuperview()
        }
        indicator.startAnimating()
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.topItem?.title = script?.title
    }
}

extension WebViewController: WKUIDelegate {
    
}

extension WebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("🕙 finished")
        indicator.stopAnimating()
        coverView.removeFromSuperview()
        self.view.layoutIfNeeded()
        loaded = true
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("🔗\(webView.url)")
        if (loaded) {
            print("sshould go back")
            let nextScript = Script.init(title: script!.title, url: webView.url?.absoluteString ?? "www.apple.com", content: script!.content, image: "nil")
            let viewController = WebViewController()
            viewController.script = nextScript
            self.navigationController?.pushViewController(viewController, animated: false)
            webView.stopLoading()
        }
    }
}
