//
//  VKUser.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/7/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//



import Foundation
import SwiftyJSON


struct Country {
    let countryId: UInt
    var title: String = ""
}

struct City {
    let cityId: UInt
    var title: String = ""
}


class VKUser {
    // MARK: Properties
    let userId: Int
    var country: Country
    var city: City
    let photo_50_url: String?
    let photo_200_url: String?
    let photo_max_url: String?
    let relation: Relation
    let sex: Gender
    let birthday: String
    let firsName: String
    let lastName: String
    var fullName: String {
        return firsName + " " + lastName
    }
    let homeTown: String?
    
    
    // MARK: Init funcs
    
//    init(userProfile parameters: Any) {
//        let pJson = JSON(parameters)
//        
//        self.userId = AuthorizationManager.sharedInstance.authorizationInfo![kUserId] as! String
//    }
    
    init(usersGet parameters: [String: AnyObject]) {
        print(parameters.keys)
        self.userId = parameters[kUID] != nil ? parameters[kUID]!.intValue : 0
        
        let countryId = parameters[kCountry]!.uintValue
        self.country = Country(countryId: countryId!, title: "")
        
        let cityId = parameters[kCity]!.uintValue
        self.city = City(cityId: cityId!, title: "")
        
        self.photo_50_url = parameters[kPhoto50] != nil ? parameters[kPhoto50] as! String : ""
        self.photo_200_url = parameters[kPhoto200] != nil ? parameters[kPhoto200] as! String : ""
        self.photo_max_url = parameters[kPhotoMax] != nil ? parameters[kPhotoMax] as! String : ""
        
        let relIndex: Int = parameters[kRelation] != nil ? parameters[kRelation]!.intValue : 0
        self.relation = Relation(rawValue: relIndex)!
        
        let sexIndex: Int = parameters[kSex] != nil ? parameters[kSex]!.intValue : 0
        self.sex = Gender(rawValue: sexIndex)!
        
        self.birthday = parameters[kBirthDate] != nil ? parameters[kBirthDate] as! String : ""
        self.firsName = parameters[kFirstName] != nil ? parameters[kFirstName] as! String : ""
        self.lastName = parameters[kLastName] != nil ? parameters[kLastName] as! String : ""
        self.homeTown = parameters[kHomeTown] as! String?
    }
    
    
    // MARK: Static funcs
    static func fieldsString(fields: [String]) -> String {
        var fieldStr = ""
        for i in 0..<fields.count {
            if i == 0 {
                fieldStr = fields[i]
            } else {
                fieldStr = fieldStr.appending(",")
                fieldStr = fieldStr.appending(fields[i])
            }
        }
        return fieldStr
    }
    
    static func idsString(ids: [Int]) -> String {
        var uidsStr = ""
        
        for i in 0..<ids.count {
            let idStr = String(ids[i])
            if i == 0 {
                uidsStr = idStr
            } else {
                uidsStr = uidsStr.appending(",")
                uidsStr = idStr
            }
        }
        
        return uidsStr
    }
    
    
    // MARK: Enums
    
    enum Relation: Int {
        case NotSpecified = 0,
        NotMarried,
        HasFriend,
        Engaged,
        Married,
        Difficult,
        ActiveSearching,
        InLove
        
        func intVaule() -> Int {
            return self.rawValue
        }
        
        func stringValue() -> String {
            var str = ""
            switch self {
            case .NotMarried:
                str = "Not Married"
            case .HasFriend:
                str = "Has Friend"
            case .Engaged:
                str = "Engaged"
            case .Married:
                str = "Married"
            case .Difficult:
                str = "Is Difficult"
            case .ActiveSearching:
                str = "Active Searching"
            case .InLove:
                str = "In Love"
            default:
                str = "Not Specified"
            }
            
            return str
        }
    }
    
    enum Gender: Int {
        case NotSpecified = 0,
        Female,
        Male
        
        func intVaule() -> Int {
            return self.rawValue
        }
        
        func stringValue() -> String {
            var str = ""
            switch self {
            case .Female:
                str = "Female"
            case .Male:
                str = "Male"
            default:
                str = "Not Specified"
            }
            
            return str
        }
    }
}
