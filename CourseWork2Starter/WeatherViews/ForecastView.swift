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
        ZStack{
            // background image
            Image("background2").resizable().ignoresSafeArea()
            VStack{
                Text("\(modelData.userLocation)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                // list of 8 day daily view
                List{
                    ForEach(modelData.forecast!.daily) { day in
                        DailyView(day: day)
                    }
                }.opacity(0.7)
            }
        }
    }
}

struct Forecast_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView().environmentObject(ModelData())
    }
}
