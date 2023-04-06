//
//  PollutionDataStructure.swift
//  CourseWork2Starter
//
//  Created by Osanda Viduda on 2023-04-01.
//

import Foundation

struct Pollution: Codable {
    let coord:Coord
    let list:[ListInfo]
}

struct Coord:Codable{
    let lon:Double
    let lat:Double
}

struct ListInfo: Codable {
    let dt:Int
    let main: Info
    let components: Components
    
//    enum CodingKeys:String, CodingKey {
//        case dt
//        case info = "main"
//        case components
//    }
}

struct Info: Codable {
    let aqi:Int
    
//    enum Codingkeys:String, CodingKey {
//        case airQulityIndex = "aqi"
//    }
}

struct Components:Codable {
    let carbonMonoxide:Double
    let nitrogenMonoxide:Double
    let nitrogenDioxide:Double
    let ozone:Double
    let sulphurDioxide:Double
    let FineParticlesMatter:Double
    let CoarseParticulateMatter:Double
    let ammonia:Double


    enum CodingKeys:String, CodingKey{
        case carbonMonoxide = "co"
        case nitrogenMonoxide = "no"
        case nitrogenDioxide = "no2"
        case ozone = "o3"
        case sulphurDioxide = "so2"
        case FineParticlesMatter = "pm2_5"
        case CoarseParticulateMatter = "pm10"
        case ammonia = "nh3"
    }
}
