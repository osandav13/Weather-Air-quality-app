//
//  PollutionView.swift
//  Coursework2
//
//  Created by GirishALukka on 30/12/2022.
//

import SwiftUI

struct PollutionView: View {
    
    @EnvironmentObject var pollutionModel: PollutionData
    @EnvironmentObject var modelData: ModelData
    @State var weatherIcon:String = ""

    var body: some View {
        
        ZStack {
            // Use ZStack for background images
            Image("background").resizable().ignoresSafeArea()
            VStack (spacing:30){
                Spacer()
                VStack(spacing:40){
                    Text("\(modelData.userLocation)")
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                        .multilineTextAlignment(.center)
                        .padding(.all)

                    Text("\((Int)(modelData.forecast?.current.temp ?? 0))°C")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
                
                HStack{
                    WeatherIcon(icon: $weatherIcon)
                    Text(modelData.forecast?.current.weather[0].weatherDescription.rawValue.capitalized ?? "No Data")
                        .foregroundColor(.black)
                }
                
                HStack(spacing:40){
                    Text("High: \((Int)(modelData.forecast?.daily[0].temp.max ?? 0))°C")
                    Text("Low: \((Int)(modelData.forecast?.daily[0].temp.min ?? 0))°C")
                }
                Text("Feels Like: \((Int)(modelData.forecast?.current.feelsLike ?? 0))ºC")
                    .foregroundColor(.black)
                Text("Air Quality Data:")
                    .font(.title)
                    .bold()
                
                HStack(spacing: 20){
                    Image("so2").resizable().scaledToFit().frame(width:80,height: 70)
                    Image("no").resizable().scaledToFit().frame(width:80,height: 70)
                    Image("voc").resizable().scaledToFit().frame(width:80,height: 70)
                    Image("pm").resizable().scaledToFit().frame(width:80,height: 70)
                }
                
                HStack(spacing: 70){
                    Text(String(pollutionModel.pollution?.list[0].components.sulphurDioxide ?? 0))
                    Text(String(pollutionModel.pollution?.list[0].components.nitrogenDioxide ?? 0))
                    Text(String(pollutionModel.pollution?.list[0].components.CoarseParticulateMatter ?? 0))
                    Text(String(pollutionModel.pollution?.list[0].components.FineParticlesMatter ?? 0))
                }
                Spacer()

                //Spacer()

            }.foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
                
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
        .onAppear{
            weatherIcon = modelData.forecast?.current.weather[0].icon ?? ""
        }
    }
}


struct PollutionPreviews: PreviewProvider {
    static var previews: some View {
        PollutionView()
            .environmentObject(PollutionData())
            .environmentObject(ModelData())
    }
}
