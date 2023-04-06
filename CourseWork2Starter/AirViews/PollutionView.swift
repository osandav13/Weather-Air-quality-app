//
//  PollutionView.swift
//  Coursework2
//
//  Created by GirishALukka on 30/12/2022.
//

import SwiftUI

struct PollutionView: View {
    
    @EnvironmentObject var airModel: PollutionData

    var body: some View {
        
        ZStack {
            // Use ZStack for background images
            Image("background").resizable().ignoresSafeArea()
            VStack {
                Text("")
                Spacer()
                Text("\(airModel.poluttion!.list[0].components.sulphurDioxide)")
                Spacer()

            }.foregroundColor(.black)
            .shadow(color: .black,  radius: 0.5)
                
        }.ignoresSafeArea(edges: [.top, .trailing, .leading])
    }
}


struct PollutionPreviews: PreviewProvider {
    static var previews: some View {
        PollutionView().environmentObject(PollutionData())
    }
}
