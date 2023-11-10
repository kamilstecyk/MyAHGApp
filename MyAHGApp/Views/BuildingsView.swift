//
//  BuildingsView.swift
//  MyAHGApp
//
//  Created by Kamil Stecyk on 19/10/2023.
//

import SwiftUI

struct BuildingsView: View {
    @EnvironmentObject var store: BuildingStore
    @Binding var buildings: [Building]
    @Environment(\.scenePhase) private var scenePhase
    @State private var showingAlert = false
    let saveAction: ()->Void
    
    var body: some View {
        NavigationStack{
            List($buildings) { $building in
                NavigationLink(destination: BuildingView(building: $building)
                    .navigationTitle("Szczegóły budynku")
                    .navigationBarTitleDisplayMode(.inline)){
                    BuildingCardView(building: building)
                }.listRowBackground(BuildingThemeManager.BackgroundColorForBuildingType(buildingType: building.buildingType))
            }
            .navigationTitle("Wszystkie budynki")
            .navigationBarTitleDisplayMode(.inline) 
            .navigationBarItems(trailing:
                            Button(action: {
                                showingAlert = true
                            }) {
                                Image(systemName: "arrow.clockwise.circle.fill")
                                    .font(.title)
                            }
                            .alert("Dane aplikacji zostaną zastąpione nowymi!", isPresented: $showingAlert) {
                                Button("OK", role: .destructive) {
                                    store.refreshDataFetchingFromAPI()
                                    showingAlert = false
                                    print("Refreshed data")
                                }
                                Button("Anuluj", role: .cancel) {
                                    showingAlert = false
                                    print("Alert cancelled")
                                }
                            }
                        )
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }}
        }
    }
}

#Preview {
    BuildingsView(buildings: .constant(Building.sampleBuildings), saveAction: {})
}
