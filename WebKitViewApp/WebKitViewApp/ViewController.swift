//
//  ViewController.swift
//  WebKitViewApp
//
//  Created by Hao Lam on 6/17/20.
//  Copyright © 2020 Hao Lam. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKNavigationDelegate, UISearchBarDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var act_ind: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string:"http://www.google.com")
        //request url to load into webview
        let request = URLRequest(url: url!)
        //load request to webview
        webView.load(request)
        
        //add a subview to an activity indicator to link and combine those 2 together
        webView.addSubview(act_ind)
        act_ind.startAnimating() // as soon as the screen pop up => the indicator will start animating
        
        //when the web show on screen => hide the indicator
        webView.navigationDelegate = self
        act_ind.hidesWhenStopped = true
        
    }

    
    @IBAction func back_action(_ sender: Any) {
        if webView.canGoBack
        {
            webView.goBack()
        }
    }
    @IBAction func forward_action(_ sender: Any) {
        if webView.canGoForward
        {
            webView.goForward()
        }
    }
    
    @IBAction func refresh_action(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func cancel_action(_ sender: Any) {
        webView.stopLoading()
    }
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        //when any web start loading into webview
        act_ind.startAnimating()
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // when webview finish loading
        act_ind.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // when webview fail to load up => Ex: lose internet connection
        act_ind.stopAnimating()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // if search button in the search bar is clicked
        searchBar.resignFirstResponder()
        
        let url = URL(string:"http://\(searchBar.text!)")
        //request url to load into webview
        let request = URLRequest(url: url!)
        //load request to webview
        webView.load(request)
        
    }
}

