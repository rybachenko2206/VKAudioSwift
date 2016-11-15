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
    
    
    func downloadAll(audioListArray: [VKAudio], completion: @escaping finished) {
        self.audioList = audioListArray
        let audio = audioList[counter]
        
        self.downloadAudio(audio: audio,
                           daCompletion: { finished in
                            
                            if self.counter == self.audioList.count {
                                completion(true)
                            } else {
                                self.downloadAll(audioListArray: audioListArray,
                                                 completion: {response in})
                            }
        })
    }
    
    func downloadAudio(audio: VKAudio, daCompletion: @escaping finished) {
        WebService.sharedInstance.downloadAudio(audio: audio,
                                                completion: {responseInfo in
                                                    
                                                    self.counter = self.counter + 1
                                                    self.handleDownloadAudioResponse(response: responseInfo)
                                                    
                                                    daCompletion(true)
        })
    }
    
    
    private func handleDownloadAudioResponse(response: ResponseInfo) {
        let audio = response.response as! VKAudio
        let fileName = audio.saveFileName()
        if response.error != nil {
            self.notDownloaded.append(audio)
            print("\n~~download file \(fileName) error: \(response.error?.localizedDescription)")
        } else {
            print("\n~~file \(fileName) is downloaded successfully")
        }
        
        if self.counter == self.audioList.count {
            print("~~downloading is finished\n~~notDownloaded count = \(self.notDownloaded.count)\n")
            print(self.notDownloaded)
        }
    }
}
