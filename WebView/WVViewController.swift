//
//  WVViewController.swift
//  WebView
//
//  Created by Acttos on 27/9/2016.
//  Copyright © 2016 Acttos.org. All rights reserved.
//

import UIKit

class WVViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!;
    @IBOutlet weak var backButton: UIButton!;
    @IBOutlet weak var forwardButton: UIButton!;
    @IBOutlet weak var refreshButton: UIButton!;
    @IBOutlet weak var shareButton: UIButton!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
 
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
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
        let activityController:UIActivityViewController = UIActivityViewController(activityItems: [], applicationActivities: []);
        self.present(activityController, animated: true) { 
            print("Share Button Clicked.")
        }
    }
    
}

