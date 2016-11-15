//
//  AudioFileManager.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/14/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import Foundation

class AudioFileManager {
    // MARK: Properties
    static func documentsDirectory() -> URL {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        
        let documentsDir: URL = urls.first!
        return documentsDir
    }
    
    static func audioFilesDirectory() -> URL {
        let fm = FileManager.default
        
        let dirName = "AudioFiles"
        let path = self.documentsDirectory().appendingPathComponent(dirName)
        
        if fm.fileExists(atPath: path.absoluteString) == false {
            do {
                try fm.createDirectory(at: path, withIntermediateDirectories: true, attributes: nil)
            } catch let error as Error {
                print(error.localizedDescription)
            }
        }
        return path
    }
    
    
}
