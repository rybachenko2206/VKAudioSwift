//
//  AuthorizationViewController.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/1/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import UIKit

class AuthorizationViewController: UIViewController, UIWebViewDelegate {
    // MARK: Outlets
    @IBOutlet weak var webView: UIWebView!
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let scopeStr = scopeString()
        let authLink = String.init(format: kAuthLinkFormat, vkAppID, scopeStr)
        let url = NSURL(string: authLink)
        if url != nil {
            let request = NSURLRequest(url: url as! URL)
            webView.loadRequest(request as URLRequest)
        }
    }
    
    
    // MARK: Delegate funcs:
    
    // MARK: —UIWebViewDelegate
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.request?.url?.absoluteString.contains("access_token") == true {
            //
        }
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("webView didFailLoadWithError: \(error.localizedDescription)")
    }
    
    // MARK: Static funcs
    
    static func storyboardIdentifier() -> String {
        return "AuthorizationViewController"
    }
    
    
    // MARK: Private funcs
    
    private func scopeString() -> String {
        var scopeStr = ""
        for element in vkScope {
            if scopeStr.characters.count == 0 {
                scopeStr = element
            } else {
                scopeStr = scopeStr + "," + element
            }
            
        }
        
        return scopeStr
    }
}
