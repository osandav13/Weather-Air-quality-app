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
    
    var body: some View {
        ZStack{
            //background image
            Image("background2").resizable().ignoresSafeArea()
            // all the other data in the home view
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    // change location button to find details of different places
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
                    // sheet view to change the location
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
                        // loading the weather icon
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
                // updating the location when the view appear
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
