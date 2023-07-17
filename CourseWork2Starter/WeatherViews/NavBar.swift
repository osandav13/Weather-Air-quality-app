//
//  NavBar.swift
//  Coursework2
//
//  Created by G Lukka.
//

import SwiftUI

struct NavBar: View {
    
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        TabView {
            // home view
           Home()
                .tabItem{
                    
                    Label("City",systemImage:"magnifyingglass")
                }
            // weathernow view
            CurrentWeatherView()
                .tabItem {
                    
                    Label("Weather Now",systemImage:"sun.max.fill")
                }
            // hourly view
            HourlyView()
                .tabItem{
                    
                    Label("Hourly Summery",systemImage: "clock.fill")
                }
            // 8 day forcast view
            ForecastView()
                .tabItem {
                    
                    Label("Forecast",systemImage:"calendar")
                }
            // air pollution view
            PollutionView()
                .tabItem {
                    
                    Label("Pollution",systemImage: "aqi.high")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        .tint(Color("tintColor"))
        
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBar().environmentObject(ModelData())
    }
}
