//
//  HourCondition.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourCondition: View {
    var current : Current
    
    var body: some View {
        
        HStack{
            HStack (alignment: .center, spacing: 8){
                VStack{
                    Text(Date(timeIntervalSince1970: Double(current.dt)).formatted(.dateTime.hour()))
                        .multilineTextAlignment(.center)
                    Text(Date(timeIntervalSince1970: Double(current.dt)).formatted(.dateTime.weekday()))
                        .multilineTextAlignment(.center)
                }
                
                WeatherIcon(icon: current.weather[0].icon)
                Text("\((Int)(current.temp))°C " + "\((current.weather[0].weatherDescription).rawValue.capitalized)")
    
            }
            Spacer()
        }
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
