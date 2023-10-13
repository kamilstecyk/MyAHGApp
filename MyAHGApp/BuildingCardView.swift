//
//  BuildingCardView.swift
//  MyAHGApp
//
//  Created by Guest User on 13/10/2023.
//

import SwiftUI

struct BuildingCardView: View {
    let building: Building
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    var sampleBuilding = Building.sampleBuildings[0]
    BuildingCardView(building: sampleBuilding)
        .background(Color.yellow)
        .previewLayout(.fixed(width: 400, height: 60))
}
