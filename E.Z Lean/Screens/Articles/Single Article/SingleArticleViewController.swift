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
    var article: Article!
    let webView = WKWebView.instance
    var initialPageLoaded = false
    
    @IBOutlet weak var progressView: UIProgressView!
    
    var disposeBag = DisposeBag()
    
    deinit {
        progressView.removeFromSuperview()
        print("deinit-SingleArticle")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.removeFromSuperview()
        webView.navigationDelegate = self
        
        configProgressView()
        
        view = webView
//        webView.load(URLRequest(url: URL(string:"about:blank")!))
        
        article.getContent { [weak self] content in
            _ = self?.webView.loadHTMLString(content, baseURL: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.setLightStyle()
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
