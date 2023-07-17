//
//  DailyView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct DailyView: View {
    var day : Daily?
    @State var weatherIcon:String = ""
    
    var body: some View {
        // list item view
        HStack {
            // weather icon from open weather
            WeatherIcon(icon: $weatherIcon)
            Spacer()
            VStack {
                Text("\(day?.weather[0].weatherDescription.rawValue.capitalized ?? "No Data")")
                
                Text("\(Date(timeIntervalSince1970: Double(day?.dt ?? 0)).formatted(.dateTime.weekday(.wide))) \(Date(timeIntervalSince1970: Double(day?.dt ?? 0)).formatted(.dateTime.day(.twoDigits)))")
                
            }
            Spacer()
            Text("\((Int)(day?.temp.max ?? 0))°C / \((Int)(day?.temp.min ?? 0))°C")
           
        }.padding(10)
        .onAppear{
            weatherIcon = day?.weather[0].icon ?? ""
        }
    }
    
}

struct DailyView_Previews: PreviewProvider {
    static var day = ModelData().forecast!.daily
    
    static var previews: some View {
        DailyView(day: day[0])
    }
}
