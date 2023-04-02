//
//  Conditions.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            Image("background2").resizable()
        
            VStack (spacing:15){
                Text("\(locationString)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                VStack (spacing:40){

        //          Temperature Info
                    
                    VStack {
                        Text("\((Int)(modelData.forecast!.current.temp))ºC")
                            .padding()
                            .font(.largeTitle)
                        HStack {
                            WeatherIcon(icon: modelData.forecast!.current.weather[0].icon)
                            Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                                .foregroundColor(.black)
                        }
                        VStack (spacing:20){
                            HStack(spacing:40){
                                Text("High: \((Int)(modelData.forecast!.daily[0].temp.max))")
                                Text("Low: \((Int)(modelData.forecast!.daily[0].temp.max))")
                            }
                            Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
                                .foregroundColor(.black)
                        }
                        
                    }.padding(30)
                    
                    VStack(spacing:50){
                        HStack(spacing:60){
                            Text("Wind Speed: \((Int)(modelData.forecast!.daily[0].windSpeed)) m/s")
                            Text("Direction: \(convertDegToCardinal(deg: modelData.forecast!.daily[0].windDeg))")

                        }
                        HStack(spacing:50){
                            Text("Humidity: \((Int)(modelData.forecast!.daily[0].humidity))%")
                            Text("Presure: \(modelData.forecast!.daily[0].pressure) hPg")

                        }
                    }
                    
                    
                }.padding(.bottom)

                HStack(spacing:10){
                    Image(systemName: "sunset.fill").foregroundColor(.yellow)
                    Text(Date(timeIntervalSince1970: Double(modelData.forecast?.current.sunset ?? 0)).formatted(.dateTime.hour().minute()))
                    Image(systemName: "sunrise.fill").foregroundColor(.yellow)
                    Text(Date(timeIntervalSince1970: Double(modelData.forecast!.current.sunrise ?? 0)).formatted(.dateTime.hour().minute()))
                }
            }
            .foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
            
        }
        .ignoresSafeArea()
        .onAppear{
            Task.init {
                self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                
            }
        }
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
