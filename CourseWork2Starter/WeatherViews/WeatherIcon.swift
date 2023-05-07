//
//  WeatherIcon.swift
//  CourseWork2Starter
//
//  Created by Osanda Viduda on 2023-04-02.
//

import SwiftUI

struct WeatherIcon: View {
    @Binding var icon:String
    @State var url = URL(string: "")
    
    var body: some View {
        HStack{
            AsyncImage(url:URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png?")){ phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                case .failure:
                    Image(systemName: "questionmark.square.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100,height: 70)
                default:
                    ProgressView()
                }
            }
        }
    }
}

