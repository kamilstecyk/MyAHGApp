//
//  BuildingsView.swift
//  MyAHGApp
//
//  Created by Kamil Stecyk on 19/10/2023.
//

import SwiftUI

struct BuildingsView: View {
    let buildings: [Building]
    
    var body: some View {
        List(buildings) { building in
            BuildingCardView(building: building)}
    }
}

#Preview {
    BuildingsView(buildings: Building.sampleBuildings)
}
