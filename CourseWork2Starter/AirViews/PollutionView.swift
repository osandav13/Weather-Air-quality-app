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
    @State var locationString:String = ""

    var body: some View {
        
        ZStack {
            // Use ZStack for background images
            Image("background").resizable().ignoresSafeArea()
            VStack (spacing:30){
                Spacer()
                VStack(spacing:40){
                    Text("\(locationString)")
                        .font(.title)
                        .foregroundColor(.black)
                        .shadow(color: .black, radius: 0.5)
                        .multilineTextAlignment(.center)

                    Text("\((Int)(modelData.forecast!.current.temp))°C")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
                
                HStack{
                    WeatherIcon(icon: modelData.forecast!.current.weather[0].icon)
                    Text(modelData.forecast!.current.weather[0].weatherDescription.rawValue.capitalized)
                        .foregroundColor(.black)
                }
                
                HStack(spacing:40){
                    Text("High: \((Int)(modelData.forecast!.daily[0].temp.max))°C")
                    Text("Low: \((Int)(modelData.forecast!.daily[0].temp.min))°C")
                }
                Text("Feels Like: \((Int)(modelData.forecast!.current.feelsLike))ºC")
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
                    Text(String(pollutionModel.poluttion!.list[0].components.sulphurDioxide))
                    Text(String(pollutionModel.poluttion!.list[0].components.nitrogenDioxide))
                    Text(String(pollutionModel.poluttion!.list[0].components.CoarseParticulateMatter))
                    Text(String(pollutionModel.poluttion!.list[0].components.FineParticlesMatter))
                }
                Spacer()

                //Spacer()

            }.foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
                
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
            .onAppear{
                Task.init {
                    self.locationString = await getLocFromLatLong(lat: modelData.forecast!.lat, lon: modelData.forecast!.lon)
                    
                }
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
