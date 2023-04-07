//
//  HomeView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 10/03/2023.
//

import SwiftUI
import CoreLocation

struct Home: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var isSearchOpen: Bool = false
    @State  var userLocation: String = ""
    
    
    var body: some View {
        VStack (spacing:30){
            Spacer()
            HStack {
                Spacer()
                
                Button {
                    self.isSearchOpen.toggle()
                } label: {
                    Text("Change Location")
                        .bold()
                        .font(.system(size: 30))
                }
                .sheet(isPresented: $isSearchOpen) {
                    SearchView(isSearchOpen: $isSearchOpen, userLocation: $userLocation)
                }
                
                
                Spacer()
            }.padding(.bottom,20)
            VStack{
                Text(userLocation)
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                
                Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                    .formatted(.dateTime.year().hour().month().day()))
                .padding()
                .font(.largeTitle)
                .foregroundColor(.black)
                .shadow(color: .black, radius: 1)
            }.padding(.top,30)
            
            
            Spacer()
            VStack{
                Text("Temp: \((Int)(modelData.forecast!.current.temp))ºC")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                
                Text("Humidity: \(modelData.forecast!.current.humidity)%")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                Text("Pressure: \(modelData.forecast!.current.pressure) hPa")
                    .padding()
                    .font(.title2)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                HStack{
                    WeatherIcon(icon: modelData.forecast?.current.weather[0].icon ?? "")
                    Text("\((modelData.forecast?.current.weather[0].weatherDescription.rawValue.capitalized)!)")
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                }
            }.padding(.top,40)
            Spacer()
        }.background(Image("background2").resizable().ignoresSafeArea())
        .onAppear {
            Task.init {
                self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                self.modelData.userLocation = self.userLocation
            }
            
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(ModelData())
    }
}
