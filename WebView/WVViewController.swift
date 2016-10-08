//
//  WVViewController.swift
//  WebView
//
//  Created by Acttos on 27/9/2016.
//  Copyright © 2016 Acttos.org. All rights reserved.
//

import UIKit

class WVViewController: UIViewController, UIWebViewDelegate {
    var pageTitle:String = "Original title";
    var pageHref:String = "Original href";
    
    @IBOutlet weak var webView: UIWebView!;
    @IBOutlet weak var backButton: UIButton!;
    @IBOutlet weak var forwardButton: UIButton!;
    @IBOutlet weak var refreshButton: UIButton!;
    @IBOutlet weak var shareButton: UIButton!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let webViewURL:URL = URL(string: "https://github.com/acttos/")!;
        let request:URLRequest = URLRequest(url: webViewURL, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 10);
        self.webView.delegate = self;
        
        self.webView.loadRequest(request);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
 
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.pageTitle = self.webView.stringByEvaluatingJavaScript(from: "document.title")!;
        self.pageHref = self.webView.stringByEvaluatingJavaScript(from: "window.location.href")!;
        
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true;
    }

    @IBAction func backButtonAction(_ sender: AnyObject) {
        if (self.webView.canGoBack) {
            self.webView.goBack();
        }
    }
    
    @IBAction func forwardButtonAction(_ sender: AnyObject) {
        if (self.webView.canGoForward) {
            self.webView.goForward();
        }
    }
    
    @IBAction func refreshButtonAction(_ sender: AnyObject) {
        self.webView.reload();
    }
    
    @IBAction func shareButtonAction(_ sender: AnyObject) {
        let activityController:UIActivityViewController = UIActivityViewController(activityItems: [self.pageTitle,self.pageHref], applicationActivities: []);
        self.present(activityController, animated: true) { 
            print("Share Button Clicked.")
        }
    }
    
}

