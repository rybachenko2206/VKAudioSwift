//
//  WebService.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/7/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//




typealias completionBlock = (ResponseInfo) -> Void


import Foundation
import AFNetworking

class WebService: AFHTTPSessionManager {
    // MARK: Properties
    static let sharedInstance = WebService.init(baseUrl: baseVkURL)
    
    // MARK: Init funcs
    required init(baseUrl: String) {
        let url = URL(string: baseVkURL)
        let configurations = URLSessionConfiguration.default
        super.init(baseURL: url, sessionConfiguration: configurations)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: Public funcs
    func getUserProfile(token: String,
                        userId: Int?,
                        completion: @escaping completionBlock) {
        var parameters: [String:AnyObject] = [kAccessToken : token as AnyObject,
                                              kVkApiVersion : vkApiVersion as AnyObject]
        if userId != nil {
            parameters[kUserId] = userId! as AnyObject!
        }
        
        self.get(apiGetProfileInfo,
                 parameters: parameters,
                 progress: {(progress: Progress) -> Void in },
                 success: {(sessionDataTask: URLSessionDataTask, response: Any?) -> Void in
                    let responseInfo = ResponseInfo(response: response, error: nil, task: sessionDataTask)
                    completion(responseInfo)
        },
                 failure: {(sessionDataTask: URLSessionDataTask?, error: Error) -> Void in
                    let responseInfo = ResponseInfo(response: nil, error: error, task: sessionDataTask)
                    completion(responseInfo)
        })
    }
    
    func getUsers(users: [String],
                  token: String,
                  fields: [String],
                  completion: @escaping completionBlock) {
        let parameters: [String: AnyObject] = [kAccessToken : token as AnyObject,
                                               kVkApiVersion : vkApiVersion as AnyObject,
                                               kFields : VKUser.fieldsString(fields: fields) as AnyObject,
                                               kUserIds : VKUser.fieldsString(fields: users) as AnyObject]
        
        self.get(apiUsersGet,
                 parameters: parameters,
                 progress: nil,
                 success: {(sessionDataTask: URLSessionDataTask, response: Any?) -> Void in
                    let responseInfo = ResponseInfo(response: response, error: nil, task: sessionDataTask)
                    completion(responseInfo)
        },
                 failure: {(sessionDataTask: URLSessionDataTask?, error: Error) -> Void in
                    let responseInfo = ResponseInfo(response: nil, error: error, task: sessionDataTask)
                    completion(responseInfo)
        })
    }
    
    func getCitiesWithIds(cityIds: [Int],
                          token: String,
                          completion: @escaping completionBlock) {
        let parameters = [kAccessToken : token as AnyObject,
                          kVkApiVersion : vkApiVersion as AnyObject,
                          kCityIds : VKUser.idsString(ids: cityIds) as AnyObject]
        self.get(apiCityById,
                 parameters: parameters,
                 progress: nil,
                 success: {(sessionDataTask: URLSessionDataTask, response: Any?) -> Void in
                    let responseInfo = ResponseInfo(response: response, error: nil, task: sessionDataTask)
                    completion(responseInfo)
        },
                 failure: {(sessionDataTask: URLSessionDataTask?, error: Error) -> Void in
                    
                    let responseInfo = ResponseInfo(response: nil, error: error, task: sessionDataTask)
                    completion(responseInfo)
        })
    }
    
    func getCountriesWithIds(countryIds: [Int],
                             token: String,
                             completion: @escaping completionBlock) {
        let parameters = [kAccessToken : token as AnyObject,
                          kVkApiVersion : vkApiVersion as AnyObject,
                          kCountryIds : VKUser.idsString(ids: countryIds) as AnyObject]
        self.get(apiCountryById,
                 parameters: parameters,
                 progress: nil,
                 success: {(sessionDataTask: URLSessionDataTask, response: Any?) -> Void in
                    let responseInfo = ResponseInfo(response: response, error: nil, task: sessionDataTask)
                    completion(responseInfo)
        },
                 failure: {(sessionDataTask: URLSessionDataTask?, error: Error) -> Void in
                    let responseInfo = ResponseInfo(response: nil, error: error, task: sessionDataTask)
                    completion(responseInfo)
        })
    }
    
    func getAudio(parameters: [String:AnyObject],
                  completion: @escaping completionBlock) {
        
        self.get(apiGetAudio,
                 parameters: parameters,
                 progress: nil,
                 success: {(sessionDataTask: URLSessionDataTask, response: Any?) -> Void in
                    let responseInfo = ResponseInfo(response: response,
                                                    error: nil,
                                                    task: sessionDataTask)
                    completion(responseInfo)
        },
                 failure: {(sessionDataTask: URLSessionDataTask?, error: Error) -> Void in
                    let responseInfo = ResponseInfo(response: nil,
                                                    error: error,
                                                    task: sessionDataTask)
                    completion(responseInfo)
        })
    }
    
    func downloadAudio(audio: VKAudio, completion: @escaping completionBlock) {
        let url: URL = URL(string: audio.url)!
        let request: URLRequest = URLRequest(url: url)
        
        let fileName = audio.saveFileName()
        var pathToSave: URL = AudioFileManager.audioFilesDirectory().appendingPathComponent(fileName)
        pathToSave = pathToSave.appendingPathExtension("mp3")
        
        self.downloadTask(with: request,
                          progress: nil,
                          destination: {(url, urlResponse) in pathToSave
                            
                            
        },
                          completionHandler: {(url, urlResponse, error) in
                            let responseInfo = ResponseInfo(response: audio, error: error, task: nil)
                            completion(responseInfo)
        }).resume()
        
    }
}
