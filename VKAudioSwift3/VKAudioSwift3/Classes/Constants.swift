//
//  Constants.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/1/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import Foundation

// vk keys
let vkAppID = "5544071"
let vkAppKey = "sOYDrQwz2w13xXSAYFXp"
let vkScope = ["friends", "audio"]


// UserDefaults keys
let kVkAuthDict = "vkAuthDict"

// Response keys
let kAccessToken = "access_token"
let kExpiresIn = "expires_in"
let kUserId = "user_id"


// URLs
let kAuthLinkFormat = "http://api.vk.com/oauth/authorize?client_id=%@&scope=%@&redirect_uri=http://api.vk.com/blank.html&display=touch&response_type=token"
