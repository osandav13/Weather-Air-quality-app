//
//  HourCondition.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourCondition: View {
    var current : Current?
    @State var weatherIcon:String = ""
    
    var body: some View {
        // hour view data
        HStack{
            HStack (alignment: .center, spacing: 8){
                VStack{
                    Text(Date(timeIntervalSince1970: Double(current?.dt ?? 0)).formatted(.dateTime.hour()))
                        .multilineTextAlignment(.center)
                    Text(Date(timeIntervalSince1970: Double(current?.dt ?? 0)).formatted(.dateTime.weekday()))
                        .multilineTextAlignment(.center)
                }
                // weather icon from open weather
                WeatherIcon(icon: $weatherIcon)
                Text("\((Int)(current?.temp ?? 0))°C " + "\(current?.weather[0].weatherDescription.rawValue.capitalized ?? "No Data")")
    
            }
            Spacer()
        }.onAppear{
            weatherIcon = current?.weather[0].icon ?? ""
        }
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
