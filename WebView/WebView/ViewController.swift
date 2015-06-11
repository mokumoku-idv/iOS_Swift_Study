//
//  ViewController.swift
//  WebView
//
//  Created by pomn on 6/11/15.
//  Copyright (c) 2015 pomn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    var strUrl = "http://girlsbaito.jp"
    
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var btnBack: UIBarButtonItem!
    @IBOutlet weak var btnForward: UIBarButtonItem!
    @IBOutlet weak var btnStop: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.webview.delegate = self
        self.loadUrl()
        self.btnStop.enabled = false
        self.btnForward.enabled = false
        self.btnBack.enabled = false

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // init load
    func loadUrl() {
        let requestUrl = NSURL(string: self.strUrl)
        let request = NSURLRequest(URL: requestUrl!)
        self.webview.loadRequest(request)
    }
    
    func assessButtonEnableStatus() {
        self.btnStop.enabled = self.webview.loading
        self.btnForward.enabled = self.webview.canGoForward
        self.btnBack.enabled = self.webview.canGoBack
    }

    // bar button action
    @IBAction func doBack(sender: UIBarButtonItem) {
        self.webview.goBack()
    }
    @IBAction func doForward(sender: UIBarButtonItem) {
        self.webview.goForward()
    }
    @IBAction func doStop(sender: UIBarButtonItem) {
        self.webview.stopLoading()
    }
    @IBAction func doRefresh(sender: UIBarButtonItem) {
        self.webview.reload()
    }
    
    // UIWebViewDelegate
    func webViewDidStartLoad(webView: UIWebView) {
        //self.assessButtonEnableStatus()
    }
    func webViewDidFinishLoad(webView: UIWebView) {
        self.assessButtonEnableStatus()
    }
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        self.assessButtonEnableStatus()
    }
}

