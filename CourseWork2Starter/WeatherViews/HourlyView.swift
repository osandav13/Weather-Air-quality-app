//
//  Hourly.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourlyView: View {
    
    @EnvironmentObject var modelData: ModelData
    @State var locationString:String = ""
    
//    init(){
//        UITableView.appearance().backgroundColor = .clear
//        UITableViewCell.appearance().backgroundColor = .clear
//    }
    
    var body: some View {
        VStack{
            
            Text("\(locationString)")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            //Image("background2")//.resizable().ignoresSafeArea()
            List {
                ForEach(modelData.forecast!.hourly) { hour in
                    HourCondition(current: hour)
                    
                }
            }.opacity(0.7)
            //.background()
        }.background(Image("background").ignoresSafeArea())
        .onAppear{
            Task.init {
                self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                
            }
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
