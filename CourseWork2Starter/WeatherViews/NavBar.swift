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
        TabView{
           Home()
                .tabItem{
                    
                    Label("City",systemImage:"magnifyingglass")
                }
            CurrentWeatherView()
                .tabItem {
                    
                    Label("Weather Now",systemImage:"sun.max.fill")
                }
            
            HourlyView()
                .tabItem{
                    
                    Label("Hourly Summery",systemImage: "clock.fill")
                }
            ForecastView()
                .tabItem {
                    
                    Label("Forecast",systemImage:"calendar")
                }
            PollutionView()
                .tabItem {
                    
                    Label("Pollution",systemImage: "aqi.high")
                }
        }.onAppear {
            UITabBar.appearance().isTranslucent = false
        }
        
    }
        
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBar().environmentObject(ModelData())
    }
}
