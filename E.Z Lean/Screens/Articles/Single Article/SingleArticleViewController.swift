//
//  SingleArticleViewController.swift
//  E.Z Lean
//
//  Created by Duy Anh on 2/7/17.
//  Copyright © 2017 E.Z Lean. All rights reserved.
//
import WebKit
import Utils
import RxSwift

extension WKWebView {
    static let instance = WKWebView(frame: .zero)
}

class SingleArticleViewController: UIViewController, WKNavigationDelegate {
    var urlStringToLoad: String!
    let webView = WKWebView.instance
    var initialPageLoaded = false
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var disposeBag = DisposeBag()
    
    deinit {
        webView.loadHTMLString("", baseURL: nil)
        progressView.removeFromSuperview()
        print("deinit-SingleArticle")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.removeFromSuperview()
        webView.navigationDelegate = self
        
        configProgressView()
        
        view = webView
        let url = URL.init(fileURLWithPath: urlStringToLoad)
        webView.loadFileURL(url, allowingReadAccessTo: url)
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
        print("fail")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("fail")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        initialPageLoaded = true
    }
}
