//
//  PollutionDataStructure.swift
//  CourseWork2Starter
//
//  Created by Osanda Viduda on 2023-04-01.
//

import Foundation

struct Pollution: Codable {
    let coord:[Double]
    let list:[List]
}

struct List: Codable {
    let dt:Int
    let info: Info
    let components: Components
    
    enum CodingKeys:String, CodingKey {
        case dt
        case info = "main"
        case components
    }
}

struct Info: Codable {
    let airQulityIndex:String
    
    enum Codingkeys:String, CodingKey {
        case airQulityIndex = "aqi"
    }
}

struct Components:Codable {
    let carbonMonoxide:String
    let nitrogenMonoxide:String
    let nitrogenDioxide:String
    let ozone:String
    let sulphurDioxide:String
    let FineParticlesMatter:String
    let CoarseParticulateMatter:String
    let ammonia:String


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
