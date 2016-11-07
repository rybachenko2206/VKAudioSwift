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
        
        AuthorizationManager.sharedInstance.authorizationInfo = nil

        self.navigationItem.title = "My Profile"
        presentAuthorizationVc()
    }

    
    // MARK: Private funcs
    
    private func presentAuthorizationVc() {
        if AuthorizationManager.sharedInstance.isAuthorized() == false {
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
