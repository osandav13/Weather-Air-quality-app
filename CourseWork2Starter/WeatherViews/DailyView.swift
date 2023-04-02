//
//  DailyView.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct DailyView: View {
    var day : Daily
    @State var url = URL(string: "")
    //@State var weekday:Date
    
    var body: some View {
        
        HStack {
            AsyncImage(url:url){ phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                case .failure:
                    Image(systemName: "questionmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 70)
                default:
                    ProgressView()
                }
            }
            Spacer()
            VStack {
                Text("\(day.weather[0].weatherDescription.rawValue.capitalized)")
                
                Text("\(Date(timeIntervalSince1970: Double(day.dt)).formatted(.dateTime.weekday(.wide))) \(Date(timeIntervalSince1970: Double(day.dt)).formatted(.dateTime.day(.twoDigits)))")
                
            }
            Spacer()
            Text("\((Int)(day.temp.max))°C / \((Int)(day.temp.min))°C")
           
        }.onAppear{
            url = URL(string:"https://openweathermap.org/img/wn/\(day.weather[0].icon)@2x.png")
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
