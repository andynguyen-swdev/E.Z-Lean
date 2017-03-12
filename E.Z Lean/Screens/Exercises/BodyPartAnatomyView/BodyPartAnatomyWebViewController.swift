//
//  BodyPartAnatomyWebViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 3/12/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//

import WebKit
import Utils
import RxSwift

class BodyPartAnatomyWebViewController: UIViewController, WKNavigationDelegate {
    var anatomy: Anatomy!
    let webView = WKWebView.instance
    var initialPageLoaded = false
    
    var progressView: UIProgressView!
    
    var disposeBag = DisposeBag()
    
    deinit {
        progressView.removeFromSuperview()
        print("deinit-BodyPartAnatomyWebView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = anatomy.tag
    
        webView.removeFromSuperview()
        webView.navigationDelegate = self
    
        progressView = UIProgressView(progressViewStyle: .default)
        configProgressView()
        
        view = webView
        //        webView.load(URLRequest(url: URL(string:"about:blank")!))
        
        let string = HTMLGenerator.createAnatomy(content: anatomy.content)
        webView.loadHTMLString(string, baseURL: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.setDarkStyle()
    }
    
    func configProgressView() {
        progressView.removeFromSuperview()
        webView.addSubview(progressView)
        progressView.progressTintColor = Colors.brightOrange
        
        progressView.topAnchor.constraint(equalTo: webView.topAnchor).isActive = true
        progressView.leftAnchor.constraint(equalTo: webView.leftAnchor).isActive = true
        progressView.rightAnchor.constraint(equalTo: webView.rightAnchor).isActive = true
        
        webView.rx
            .observe(Double.self, #keyPath(WKWebView.estimatedProgress))
            .subscribe(onNext: { [weak self] in
                self?.progressView.progress = Float($0!)
                self?.progressView.isHidden = $0 == 1
            })
            .addDisposableTo(disposeBag)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if !initialPageLoaded {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        initialPageLoaded = true
    }
}

