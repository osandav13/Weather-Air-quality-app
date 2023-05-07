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
    //@State  var userLocation: String = ""
    //@State var new:String = ""
    
    var body: some View {
        ZStack{
            Image("background2").resizable().ignoresSafeArea()
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isSearchOpen.toggle()
                    }) {
                        HStack {
                            Image(systemName: "location")
                                .font(.title)
                            Text("Change Location")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("buttonColor"))
                        .cornerRadius(40)
                    }
                    
//                    Button(action:{
//                        self.isSearchOpen.toggle()
//                    }){
//                        HStack{
//                            Image(systemName: "location")
//                            Text("Change Location")
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color("new"))
//                                //.bold()
//                                .font(.system(size: 30))
//                                //.border(Color.blue,width: 3)
//                                .cornerRadius(30)
//                        }
//                    }
                    .sheet(isPresented: $isSearchOpen) {
                        SearchView(isSearchOpen: $isSearchOpen)
                            .presentationDetents([.medium])//, userLocation: $userLocation)
                            .presentationDragIndicator(.visible)
                    }
                    
                    
                    Spacer()
                }.padding(.bottom,10)
                VStack{
                    Text(modelData.userLocation)
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                        .multilineTextAlignment(.center)
                        .padding(.all)
                    
                    Text(Date(timeIntervalSince1970: TimeInterval(((Int)(modelData.forecast?.current.dt ?? 0))))
                        .formatted(.dateTime.year().hour().month().day()))
                    .padding()
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 1)
                }.padding(.top,30)
                
                
                Spacer()
                VStack{
                    //if let temp = modelData.forecast?.current.temp
                    Text("Temp: \((Int)(modelData.forecast?.current.temp ?? 0))ºC")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    
                    Text("Humidity: \(modelData.forecast?.current.humidity ?? 0)%")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    Text("Pressure: \(modelData.forecast?.current.pressure ?? 0) hPa")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                    HStack{
                        //Text(modelData.forecast!.current.weather[0].icon)
                        //WeatherIcon(icon: modelData.forecast!.current.weather[0].icon)
                        AsyncImage(url:URL(string: "https://openweathermap.org/img/wn/\(modelData.forecast!.current.weather[0].icon)@2x.png?")){ phase in
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
                        Text("\((modelData.forecast?.current.weather[0].weatherDescription.rawValue.capitalized ?? "No Data"))")
                            .font(.title2)
                            .foregroundColor(.black)
                            .shadow(color: .black, radius: 0.5)
                    }
                }.padding(.top,40)
                Spacer()
            }
        }.onAppear {
            Task.init {
                //new = modelData.forecast!.current.weather[0].icon
                //self.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                self.modelData.userLocation = await getLocFromLatLong(lat: modelData.forecast?.lat ?? 0, lon: modelData.forecast?.lon ?? 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Home().environmentObject(ModelData())
    }
}
