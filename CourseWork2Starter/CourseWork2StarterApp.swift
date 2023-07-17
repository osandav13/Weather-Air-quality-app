//
//  CourseWork2StarterApp.swift
//  CourseWork2Starter
//
//  Created by GirishALukka on 16/03/2023.
//

import SwiftUI

@main
struct CourseWork2StarterApp: App {
    @StateObject var modelData = ModelData()
    @StateObject var pollutionData = PollutionData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(pollutionData)
        }
    }
}
