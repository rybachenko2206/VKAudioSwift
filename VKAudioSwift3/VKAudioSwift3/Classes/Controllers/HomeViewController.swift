//
//  HomeViewController.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/1/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: Outlets
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Home"
        presentAuthorizationVc()
    }

    
    // MARK: Private funcs
    private func accessToken() -> String? {
        let token = UserDefaults.standard.string(forKey: kVKAccessToken)
        
        return token
    }
    
    private func presentAuthorizationVc() {
        let token = accessToken()
        if token == nil {
            let stIdentifier = AuthorizationViewController.storyboardIdentifier()
            let authVc = UIStoryboard.main().instantiateViewController(withIdentifier: stIdentifier)
            present(authVc, animated: false, completion: nil)
        }
    }
    
    
    // MARK: Static funcs
    static func storyboardIdentifier() -> String {
        return "HomeViewController"
    }

    
}
