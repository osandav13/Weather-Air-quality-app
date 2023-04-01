//
//  Forecast.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct ForecastView: View {
    @EnvironmentObject var modelData: ModelData
    @State var locationString: String = "No location"
    var body: some View {
        
        VStack{
            Text("\(locationString)")
                .font(.largeTitle)
                //.fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)

            List{
                ForEach(modelData.forecast!.daily) { day in
                    DailyView(day: day)
                }
            }.opacity(0.7)
        }.background(Image("background2").resizable().ignoresSafeArea())
        .onAppear {
            Task.init {
                self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
               
            }
        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
