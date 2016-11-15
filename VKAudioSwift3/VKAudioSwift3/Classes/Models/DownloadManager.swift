//
//  DownloadManager.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/14/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import Foundation

typealias finished = (Bool) -> Void


class DownloadManager {
    // MARK: Properties
    static let sharedInstance = DownloadManager()
    
    var audioList: [VKAudio] = []
    var notDownloaded: [VKAudio] = []
    
    var counter: Int = 0
    var isDownloading = false {
        didSet {
            if isDownloading == false && counter < audioList.count {
                let audio = audioList[counter]
                isDownloading = true
                self.downloadAudio(audio: audio,
                                   completion: {(finished: Bool) -> Void in
                                    
                })
            }
        }
    }
    
    
    func downloadAll(audioList: [VKAudio], completion: @escaping finished) {
        let audio = audioList[counter]
        isDownloading = true
        downloadAudio(audio: audio,
                      completion: { finished in
                        
                        if self.counter == self.audioList.count {
                            completion(true)
                        }
        })
    }
    
    func downloadAudio(audio: VKAudio, completion: @escaping finished) {
        WebService.sharedInstance.downloadAudio(audio: audio,
                                                completion: {responseInfo in
                                                    self.isDownloading = false
                                                    
                                                    self.counter = self.counter + 1
                                                    
                                                    self.handleDownloadAudioResponse(response: responseInfo)
                                                    
                                                    if responseInfo.error != nil {
                                                        self.notDownloaded.append(audio)
                                                    }
                                                    
                                                    if self.counter == self.audioList.count {
                                                        print("\n~~notDownloaded count = \(self.notDownloaded.count)\n")
                                                        print(self.notDownloaded)
                                                        completion(true)
                                                    }
                                                    
        })
    }
    
    
    private func handleDownloadAudioResponse(response: ResponseInfo) {
        let audio = response.response as! VKAudio
        let fileName = audio.saveFileName()
        if response.error != nil {
            print("\n~~download file \(fileName) error: \(response.error?.localizedDescription)")
        } else {
            print("\n~~file \(fileName) is downloaded successfully")
        }
        self.isDownloading = false
    }
}
