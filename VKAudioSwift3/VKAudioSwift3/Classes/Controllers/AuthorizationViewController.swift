//
//  AuthorizationViewController.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/1/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import UIKit
import SVProgressHUD

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
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        SVProgressHUD.show()
        
        return true
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        if webView.request?.url?.absoluteString.contains("access_token") == true {
            let authParams = fetchParametersFromURL(url: webView.request!.url!)
            if authParams != nil && (authParams?.keys.count)! > 0 {
                AuthorizationManager.sharedInstance.authorizationInfo = authParams
                self.dismiss(animated: true, completion: nil)
            }
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
    
    private func fetchParametersFromURL(url: URL) -> [String:AnyObject]? {
        var parameters = [String:AnyObject]()
        let responseStr = url.absoluteString
        
        let urlComponents = URLComponents(string: responseStr)
        let fragmentStr = urlComponents?.fragment
        if let paramsStr = fragmentStr {
            let componetsAr = paramsStr.components(separatedBy: "&")
            
            for component in componetsAr {
                let paramAr = component.components(separatedBy: "=")
                parameters[paramAr.first!] = paramAr.last! as AnyObject?
            }
        }
        
        if parameters.keys.contains(kAccessToken) &&
            parameters.keys.contains(kExpiresIn) &&
            parameters.keys.contains(kUserId) {
            
            return parameters
        }
        
        return nil
    }
    
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
