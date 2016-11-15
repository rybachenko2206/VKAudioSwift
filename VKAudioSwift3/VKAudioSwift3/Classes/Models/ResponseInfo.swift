//
//  ResponseInfo.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/7/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import Foundation

class ResponseInfo {
    // MARK: Properties
    let response: Any?
    let error: Error?
    let statusCode: Int?
    
    required init(response: Any?, error: Error?, task: URLSessionDataTask?) {
        self.response = response
        self.error = error

        let urlResponse: HTTPURLResponse? = task?.response as? HTTPURLResponse
        self.statusCode = urlResponse?.statusCode
    }
}
