//
//  Hourly.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct HourlyView: View {
    
    @EnvironmentObject var modelData: ModelData
    //@State var locationString:String = ""
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .ignoresSafeArea()
            VStack{
                Text("\(modelData.userLocation)")
                    .font(.title)
                    //.fontWeight(.semibold)
                    .foregroundColor(.black)
                    .shadow(color: .black, radius: 0.5)
                    .multilineTextAlignment(.center)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                //Image("background2")//.resizable().ignoresSafeArea()
                List {
                    ForEach(modelData.forecast!.hourly) { hour in
                        HourCondition(current: hour)
                    }
                }.opacity(0.7)
            }
            //.background()
        }//.background(Image("background").ignoresSafeArea())
    }
}

struct Hourly_Previews: PreviewProvider {
    static var previews: some View {
        HourlyView().environmentObject(ModelData())
    }
}
