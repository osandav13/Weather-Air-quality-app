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
    //@Binding var userLocation: String
    //This is the search view that will allow user to enter new location and the .OnCommit should handle conversion to geo coords and then reversed to get the location if it exists. \n The geo coords are then used to update the weather data for the new location and all views should be updated in rdeal time.\n There is no code to do this - you must create this code.
    var body: some View {
        //Spacer()
        ZStack {
            Color("buttonColor")
                .ignoresSafeArea()
            
            VStack{
//                Text("uytfuy")
//                    .font(.subheadline)
//                    .fontWeight(.bold)
//                    .multilineTextAlignment(.center)
//                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
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
                                    async let fetchForcastData: () = modelData.loadData(lat:lat,lon: lon)
                                    async let fetchPollutionData: () = pollutionData.fetch(lat:lat,lon:lon)
                                    
                                    let (_, _) = await(try fetchForcastData, try fetchPollutionData)
                                    
                                    async let getLocationData = getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                                    let location = await getLocationData
                                    
                                    //print(forcastData)
                                    //self.modelData.forecast = forcastData
                                    //self.pollutionData.pollution = pollutionData
                                    self.modelData.userLocation = location
                                    //modelData.userLocation = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                                    //pollutionModel.poluttion = try await pollutionModel.fetch(lat:lat,lon:lon)
                                    //print(location)
                                    
                                }catch{
                                    showingAlert = true
                                    print(error)
                                }
                                isSearchOpen.toggle()
                            }
                        }
                        
                            
                    }//GEOCorder
                } //Commit
                          
                )// TextField
                .padding(10)
                .shadow(color: .blue, radius: 10)
                .cornerRadius(10)
                .fixedSize()
                .font(.custom("Ariel", size: 26))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                //.background(Color("background"))
                .cornerRadius(15) // TextField
                
            }//VStak
            
            
        }.alert("Location Doesn't Exist",isPresented:$showingAlert){
            Button("Ok",role:.cancel){}
        }// Zstack
    }// Some
    
} //View
