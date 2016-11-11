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

// JSON keys
let kAccessToken = "access_token"
let kExpiresIn = "expires_in"
let kUserId = "user_id"
let kResponse = "response"
let kBirthDate = "bdate"
let kBirthDateVisibility = "bdate_visibility"
let kCity = "city"
let kCid = "cid"
let kTitle = "title"
let kCountry = "country"
let kFirstName = "first_name"
let kLastName = "last_name"
let kHomeTown = "home_town"
let kPhone = "phone"
let kRelation = "relation"
let kSex = "sex"
let kStatus = "status"
let kPhoto50 = "photo_50"
let kPhoto200 = "photo_200"
let kPhotoMax = "photo_max"
let kFields = "fields"
let kUserIds = "user_ids"
let kUID = "uid"
let kCityIds = "city_ids"
let kCountryIds = "country_ids"



// vk API version
let kVkApiVersion = "V"
let vkApiVersion = 5.60

// API Methods
let baseVkURL = "https://api.vk.com/method"
let apiGetProfileInfo = "account.getProfileInfo"
let apiUsersGet = "users.get"
let apiCountryById = "database.getCountriesById"
let apiCityById = "database.getCitiesById"
let apiGetAudio = "audio.get"
let apiGetAlbums = "audio.getAlbums"



// URLs
let kAuthLinkFormat = "http://api.vk.com/oauth/authorize?client_id=%@&scope=%@&redirect_uri=http://api.vk.com/blank.html&display=touch&response_type=token"


let userParameters = [kBirthDate,
                      kCity,
                      kCountry,
                      kFirstName,
                      kLastName,
                      kHomeTown,
                      kSex,
                      kStatus,
                      kRelation,
                      kPhoto50,
                      kPhoto200,
                      kPhotoMax]

let getAudiosMaxCount = 5000
