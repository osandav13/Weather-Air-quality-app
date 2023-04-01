//
//  HourCondition.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourCondition: View {
    var current : Current
    @State var icon:String = ""
    @State var url = URL(string:"")
    
    var body: some View {
        
        HStack {
            HStack {
                Text(Date(timeIntervalSince1970: Double(current.dt)).formatted(.dateTime.hour().weekday()))
                    .multilineTextAlignment(.center)
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
                Text("\((Int)(current.temp))°C " + "\((current.weather[0].weatherDescription).rawValue.capitalized)")
                    .multilineTextAlignment(.center)
            }.padding(10)
            Spacer()
        }
        .onAppear{
            url = URL(string:"https://openweathermap.org/img/wn/\(current.weather[0].icon)@2x.png")
        }
        .padding()
    }
}

struct HourCondition_Previews: PreviewProvider {
    static var hourly = ModelData().forecast!.hourly
    
    static var previews: some View {
        HourCondition(current: hourly[0])
    }
}
