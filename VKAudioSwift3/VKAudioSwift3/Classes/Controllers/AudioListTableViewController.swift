//
//  AudioListTableViewController.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/12/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import UIKit
import SVProgressHUD
import SwiftyJSON

class AudioListTableViewController: UITableViewController, AudioCellDelegate {
    // MARK: Outlets
    @IBOutlet var downloadAllBarButtonItem: UIBarButtonItem!
    
    // MARK: Properties
    var audioList: [VKAudio] = []
    
    
    // MARK: Static funcs
    static func storyboardIdentifier() -> String {
        return "AudioListTableViewController"
    }
    
    
    // MARK: Overriden funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Playlist"
        navigationItem.rightBarButtonItem = downloadAllBarButtonItem
        
        let cellNib = UINib.init(nibName: AudioCell.cellIdentifier(), bundle: nil)
        self.tableView.register(cellNib, forCellReuseIdentifier: AudioCell.cellIdentifier())
        
        getAudioWith(offset: 0,
                     count: audiosMaxCount,
                     albumId: nil,
                     audioIds: nil)
    }
    
    
    // MARK: Action funcs

    @IBAction func downloadAllButtonTapped(_ sender: UIButton) {
        SVProgressHUD.show(withStatus: "Downloading..")
        DownloadManager.sharedInstance.downloadAll(audioListArray: audioList,
                                                   completion: {finished in
                                                    if finished == true {
                                                        SVProgressHUD.show(withStatus: "Finished")
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000),
                                                                                      execute: {() -> Void in
                                                            SVProgressHUD.dismiss()
                                                        })
                                                    }
        
        })
    }
    
    // MARK: Delegate funcs:
    // MARK: —UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return audioList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = AudioCell.cellIdentifier()
        
        let cell: AudioCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                            for: indexPath) as! AudioCell
        cell.delegate = self
        cell.audio = audioList[indexPath.row]

        return cell
    }
    
    
    // MARK: —UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return AudioCell.cellHeight() 
    }
    
    
    // MARK: —AudioCellDelegate
    
    func playButtonTappedInCell(cell: AudioCell) {
        //
    }
    
    func downloadButtonTappedInCell(cell: AudioCell) {
        SVProgressHUD.show()
        WebService.sharedInstance.downloadAudio(audio: cell.audio!,
                                                completion: {response in
                                                    SVProgressHUD.dismiss()
        })
    }


    // MARK: Private funcs
    
    private func getAudioWith(offset: Int, count: Int, albumId: Int?, audioIds: [Int]?) {
        SVProgressHUD.show()
        
        let userId = AuthorizationManager.sharedInstance.currentUser?.userId
        let token = AuthorizationManager.sharedInstance.authorizationInfo![kAccessToken]
        
        var parameters: [String:AnyObject] = [kAccessToken : token!,
                                              kVkApiVersion : vkApiVersion as AnyObject,
                                              kNeedUser : false as AnyObject,
                                              kOwnerId : userId as AnyObject,
                                              kOffset : offset as AnyObject,
                                              kCount : count as AnyObject]
        
        if let albumID = albumId {
            parameters[kAlbumId] = albumID as AnyObject
        }
        
        if let audioIdsAr = audioIds {
            parameters[kAudioIds] = VKUser.idsString(ids: audioIdsAr) as AnyObject
        }
        
        WebService.sharedInstance.getAudio(parameters:parameters,
                                           completion:{(response: ResponseInfo) -> Void in
                                            
                                            SVProgressHUD.dismiss()
                                            self.handleGetAudioResponse(response: response)
                                            
        })
    }
    
    private func handleGetAudioResponse(response: ResponseInfo) {
        
        if response.response != nil {
            let serverResponse = response.response as! [String : AnyObject]
            
            var array: Array<AnyObject> = serverResponse[kResponse] as! Array<AnyObject>
            
            if let firstElement = array.first as! Int? {
                print(firstElement)
                array.remove(at: 0)
                
                
                for item in array {
                    let dict = item as! [String:AnyObject]
                    let vkAudio = VKAudio.init(parameters: dict)
                    self.audioList.append(vkAudio)
                }
            }
            self.tableView.reloadData()
        } else {
            // TODO: handle response error
        }
    }

}
