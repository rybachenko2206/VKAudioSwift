//
//  VKAudio.swift
//  VKAudioSwift3
//
//  Created by Roman Rybachenko on 11/11/16.
//  Copyright © 2016 Roman Rybachenko. All rights reserved.
//

import Foundation

class VKAudio {
    
    enum Genre: Int {
        case Rock = 1
        case Pop = 2
        case RapAndHipHop = 3
        case EasyListening = 4
        case HouseAndDance = 5
        case Instrumental = 6
        case Metal = 7
        case Dubstep = 8
        
        case DramAndBass = 10
        case Trance = 11
        case Chanson = 12
        case Ethnic = 13
        case AccusticAndVocal = 14
        case Reggae = 15
        case Classical = 16
        case IndiePop = 17
        case Other = 18
        case Speech = 19
        
        case Alternative = 21
        case ElectropopAndDisco = 22
        
        case JazzAndBlues = 1001
        
        // MARK: Enum func
        
        static func defaultGenge() -> Genre {
            return Genre.Other
        }
        
        func stringValue() -> String {
            var strValue = ""
            switch self {
            case .Rock:
                strValue = "Rock"
            case .Pop:
                strValue = "Pop"
            case .RapAndHipHop:
                strValue = "Rap & Hip-Hop"
            case .EasyListening:
                strValue = "Easy Listening"
            case .HouseAndDance:
                strValue = "House & Dance"
            case .Instrumental:
                strValue = "Instrumental"
            case .Metal:
                strValue = "Metal"
            case .Dubstep:
                strValue = "Dubstep"
            case .DramAndBass:
                strValue = "Drum & Bass"
            case .Trance:
                strValue = "Trance"
            case .Chanson:
                strValue = "Chanson"
            case .Ethnic:
                strValue = "Ethnic"
            case .AccusticAndVocal:
                strValue = "Acoustic & Vocal"
            case .Reggae:
                strValue = "Reggae"
            case .Classical:
                strValue = "Classical"
            case .IndiePop:
                strValue = "Indie Pop"
            case .Speech:
                strValue = "Speech"
            case .ElectropopAndDisco:
                strValue = "Electropop & Disco"
            case .Alternative:
                strValue = "Alternative"
            default:
                strValue = "Other"
            }
            
            return strValue
        }
    }
}
