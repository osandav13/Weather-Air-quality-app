//
//  SearchView.swift
//  CWK2_23_GL
//
//  Created by GirishALukka on 11/03/2023.
//

import SwiftUI
import CoreLocation

struct SearchView: View {
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var pollutionData: PollutionData
    
    @Binding var isSearchOpen: Bool
    @State var showingAlert:Bool = false
    @State var location = ""

    var body: some View {
        
        ZStack {
            Color("buttonColor")
                .ignoresSafeArea()
            
            VStack{
                TextField("Enter New Location", text: self.$location, onCommit: {
                     
                    CLGeocoder().geocodeAddressString(location) { (placemarks, error) in

                        if error != nil {
                            showingAlert = true
                            return
                        }
                        if let lat = placemarks?.first?.location?.coordinate.latitude,
                           let lon = placemarks?.first?.location?.coordinate.longitude {
                            Task{
                                do{
                                    // fetching data from openweather
                                    async let fetchForcastData: () = modelData.fetchWeather(lat:lat,lon: lon)
                                    async let fetchPollutionData: () = pollutionData.fetchAirPollution(lat:lat,lon:lon)
                                    // network call
                                    let (_, _) = await(try fetchForcastData, try fetchPollutionData)
                                    // getting location string
                                    async let getLocationData = getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                                    let location = await getLocationData
                                    //setting user location
                                    self.modelData.userLocation = location
                                }catch{
                                    // showing the alert if there is a error
                                    showingAlert = true
                                    print(error)
                                }
                                isSearchOpen.toggle()
                            }
                        }
                    }//GEOCorder
                } //Commit
                          
                )
                .padding(10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .cornerRadius(15)
                
            }//VStak
        }.alert("Location Doesn't Exist",isPresented:$showingAlert){
            Button("Try Again",role:.cancel){}
        }// Zstack
    }// Some
} //View
