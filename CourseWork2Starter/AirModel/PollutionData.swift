//
//  PollutionData.swift
//  CourseWork2Starter
//
//  Created by Osanda Viduda on 2023-04-01.
//

import Foundation

class PollutionData: ObservableObject{
    
    @Published var pollution: Pollution?
    
    init (){
        self.pollution = load(filename: "london air.json")
    }
    
    //get data from the openweather api and add the the data to the pollution model
    func fetch(lat:Double, lon:Double) async throws {
        let url = URL(string:"https://api.openweathermap.org/data/2.5/air_pollution?lat=\(lat)&lon=\(lon)&appid=\(API.key)")!
        do{
            let (Data,_) = try await URLSession.shared.data(from:url,delegate:nil)
            let pollutionData = try JSONDecoder().decode(Pollution.self, from: Data)
            DispatchQueue.main.async {
                self.pollution = pollutionData
            }
        } catch {
            throw error
        }
    }
    
    // loading the initial poluution data that will be used in the pollution view
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

