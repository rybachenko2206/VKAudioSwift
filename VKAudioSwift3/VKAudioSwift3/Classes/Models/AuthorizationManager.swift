//
//  AuthorizationManager.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/7/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import Foundation


class AuthorizationManager {
    // MARK: Properties
    static let sharedInstance = AuthorizationManager()
    
    var authorizationInfo: [String : AnyObject]? {
        get {
            return UserDefaults.standard.value(forKey: kVkAuthDict) as! [String : AnyObject]?
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey:kVkAuthDict)
        }
    }
    
    
    // MARK: Public funcs
    func isAuthorized() -> Bool {
        if authorizationInfo != nil {
            return true
        }
        
        return false
    }
}
