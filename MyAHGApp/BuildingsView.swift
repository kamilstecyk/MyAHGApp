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
        NavigationStack{
            List(buildings) { building in
                NavigationLink(destination: BuildingView(building: building)
                    .navigationTitle("Szczegóły budynku")){
                    BuildingCardView(building: building)
                }.listRowBackground(BuildingThemeManager.BackgroundColorForBuildingType(buildingType: building.buildingType))
            }
            .navigationTitle("Wszystkie budynki")
        }
    }
}

#Preview {
    BuildingsView(buildings: Building.sampleBuildings)
}
