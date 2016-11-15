//
//  HomeViewController.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/1/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON
import SDWebImage

class HomeViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var birthLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var relationLabel: UILabel!
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthorizationManager.sharedInstance.authorizationInfo = nil

        self.navigationItem.title = "My Profile"
        presentAuthorizationVc()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getUserInfo()
        
        avatarImageView.layer.cornerRadius = 8.0
    }
    
    
    // MARK: Action funcs

    @IBAction func audioButtonTapped(_ sender: UIButton) {
        let storyboardId = AudioListTableViewController.storyboardIdentifier()
        let audioVc = UIStoryboard.main().instantiateViewController(withIdentifier: storyboardId)
        navigationController?.pushViewController(audioVc, animated: true)
    }
    
    // MARK: Private funcs
    
    private func showUser() {
        guard let user = AuthorizationManager.sharedInstance.currentUser
            else { return }
        
        birthLabel.text = user.birthday
        nameLabel.text = user.fullName
        genderLabel.text = user.sex.stringValue()
        relationLabel.text = user.relation.stringValue()
        if user.photo_200_url != nil, let avaUrl = URL(string: user.photo_200_url!) {
            let plImage = UIImage(named: "placeholerImage")
            avatarImageView.sd_setImage(with: avaUrl, placeholderImage: plImage)
        }
    }
    
    private func presentAuthorizationVc() {
        if AuthorizationManager.sharedInstance.isAuthorized() == false {
            let stIdentifier = AuthorizationViewController.storyboardIdentifier()
            let authVc = UIStoryboard.main().instantiateViewController(withIdentifier: stIdentifier)
            present(authVc, animated: false, completion: nil)
        }
    }
    
    private func getUserInfo() {
        if AuthorizationManager.sharedInstance.isAuthorized() &&
            AuthorizationManager.sharedInstance.authorizationInfo != nil {
            let token = AuthorizationManager.sharedInstance.authorizationInfo![kAccessToken]
            let userIdStr = AuthorizationManager.sharedInstance.authorizationInfo![kUserId] as! String
            
            SVProgressHUD.show()
            WebService.sharedInstance.getUsers(users: [userIdStr],
                                               token: token as! String,
                                               fields: userParameters,
                                               completion: {(respInfo: ResponseInfo) -> Void in
                                                SVProgressHUD.dismiss()
                                                if let error = respInfo.error {
                                                    print("users.get error \(error.localizedDescription)")
                                                    // TODO: to code error handling
                                                } else {
                                                    guard let responseDict = respInfo.response as? [String:AnyObject]
                                                        else { return }
                                                    let responseArray = responseDict[kResponse]
                                                    let user = VKUser.init(usersGet: responseArray?.firstObject as! [String : AnyObject])
                                                    AuthorizationManager.sharedInstance.currentUser = user
                                                    self.showUser()
                                                }
            })
        }
    }

    
    // MARK: Static funcs
    static func storyboardIdentifier() -> String {
        return "HomeViewController"
    }

    
}
