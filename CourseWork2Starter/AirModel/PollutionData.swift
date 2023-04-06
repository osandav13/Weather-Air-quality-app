//
//  PollutionData.swift
//  CourseWork2Starter
//
//  Created by Osanda Viduda on 2023-04-01.
//

import Foundation

class PollutionData: ObservableObject{
    
    @Published var poluttion: Pollution?
    
    init (){
        self.poluttion = load(filename: "london air.json")
    }
    
    func fetch(lat:String, lon:String){
        let url = URL(string:"https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(API.key)")
        //URLSession
        
    }
    
    func load<Pollution:Decodable>(filename:String) -> Pollution{
        let data:Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else{
            fatalError("\(filename) file not found")
        }
        
        do{
            data = try Data(contentsOf: file)
        }catch {
            fatalError("Erorr while loading \(filename). Error is \(error)")
        }
        
        do{
            let decorder = JSONDecoder()
            let jsonData = try decorder.decode(Pollution.self, from: data)
            return jsonData
        }catch {
            fatalError("Couldn't parse \(filename) as \(Pollution.self):\n\(error)")
            
        }
    }
    
}

