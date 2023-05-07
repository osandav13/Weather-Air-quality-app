//
//  Conditions.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var modelData: ModelData
    @State var weatherIcon:String = ""
    //@State var locationString: String = "No location"
    
    var body: some View {
        ZStack {
            Image("background2").resizable()
        
            VStack (spacing:15){
                Text("\(modelData.userLocation)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

                VStack (spacing:40){

        //          Temperature Info
                    
                    VStack {
                        Text("\((Int)(modelData.forecast?.current.temp ?? 0))ºC")
                            .padding()
                            .font(.largeTitle)
                        HStack {
                            WeatherIcon(icon: $weatherIcon)
                            Text(modelData.forecast?.current.weather[0].weatherDescription.rawValue.capitalized ?? "No Data")
                                .foregroundColor(.black)
                        }.onAppear{
                            
                        }
                        VStack (spacing:20){
                            HStack(spacing:40){
                                Text("High: \((Int)(modelData.forecast?.daily[0].temp.max ?? 0))")
                                Text("Low: \((Int)(modelData.forecast?.daily[0].temp.max ?? 0))")
                            }
                            Text("Feels Like: \((Int)(modelData.forecast?.current.feelsLike ?? 0))ºC")
                                .foregroundColor(.black)
                        }
                        
                    }.padding(30)
                    
                    VStack(spacing:50){
                        HStack(spacing:60){
                            Text("Wind Speed: \((Int)(modelData.forecast?.daily[0].windSpeed ?? 0)) m/s")
                            Text("Direction: \(convertDegToCardinal(deg: modelData.forecast?.daily[0].windDeg ?? 0))")

                        }
                        HStack(spacing:50){
                            Text("Humidity: \((Int)(modelData.forecast?.daily[0].humidity ?? 0))%")
                            Text("Presure: \(modelData.forecast?.daily[0].pressure ?? 0) hPg")

                        }
                    }
                    
                    
                }//.padding(.bottom)

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
//            Task.init {
                weatherIcon = modelData.forecast?.current.weather[0].icon ?? ""
//                //self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
//
//            }
        }
    }
}

struct Conditions_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
            .environmentObject(ModelData())
    }
}
