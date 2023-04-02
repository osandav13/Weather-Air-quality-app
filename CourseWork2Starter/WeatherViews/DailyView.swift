//
//  DailyView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct DailyView: View {
    var day : Daily

    var body: some View {
        
        HStack {
            WeatherIcon(icon: day.weather[0].icon)
            Spacer()
            VStack {
                Text("\(day.weather[0].weatherDescription.rawValue.capitalized)")
                
                Text("\(Date(timeIntervalSince1970: Double(day.dt)).formatted(.dateTime.weekday(.wide))) \(Date(timeIntervalSince1970: Double(day.dt)).formatted(.dateTime.day(.twoDigits)))")
                
            }
            Spacer()
            Text("\((Int)(day.temp.max))°C / \((Int)(day.temp.min))°C")
           
        }
        .padding(10)
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
