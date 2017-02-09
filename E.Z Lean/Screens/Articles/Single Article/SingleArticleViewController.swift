//
//  SingleArticleViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//
import WebKit
import UIKit

extension WKWebView {
    static let instance = WKWebView(frame: .zero)
}

class SingleArticleViewController: UIViewController, WKNavigationDelegate {
    var urlStringToLoad: String!
    let webView = WKWebView.instance
    var initialPageLoaded = false
    
    deinit {
        webView.loadHTMLString("", baseURL: nil)
        print("deinit-SingleArticle")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.removeFromSuperview()
        webView.navigationDelegate = self
        //        webView.backgroundColor = .white
        view = webView
        let url = URL.init(fileURLWithPath: urlStringToLoad)
            webView.loadFileURL(url, allowingReadAccessTo: url)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if !initialPageLoaded {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("fail")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("fail")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        initialPageLoaded = true
    }
}
