//
//  Hourly.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourlyView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        ZStack{
            // background image
            Image("background")
                .resizable()
                .ignoresSafeArea()
            // hourly view data
            VStack{
                Text("\(modelData.userLocation)")
                    .font(.title)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                // 48 hour list view
                List {
                    ForEach(modelData.forecast!.hourly) { hour in
                        HourCondition(current: hour)
                    }
                }.opacity(0.7)
            }
        }
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
