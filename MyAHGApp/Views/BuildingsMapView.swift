//
//  BuildingsMapView.swift
//  MyAHGApp
//
//  Created by Kamil Stecyk on 27/11/2023.
//

import SwiftUI
import _MapKit_SwiftUI

struct BuildingsMapView: View {
    @Binding var buildings: [Building]

    var body: some View {
        Map() {
            ForEach(buildings) { building in
                if building.isFavourite {
                    MapPolygon(building.shape).foregroundStyle(BuildingThemeManager.BackgroundColorForBuildingType(buildingType: building.buildingType))
                        .stroke(lineWidth: 5)
                        .stroke(.red)
                }else {
                    MapPolygon(building.shape).foregroundStyle(BuildingThemeManager.BackgroundColorForBuildingType(buildingType: building.buildingType))
                        
                }
                
            }
            ForEach(buildings) { building in
                Marker(building.symbol, systemImage: "building.2.fill", coordinate: building.shape.coordinate)
                    .tint(BuildingThemeManager.BackgroundColorForBuildingType(buildingType: building.buildingType).opacity((0.25)))
            }
            UserAnnotation()
        }
        .mapControls{
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        .onAppear{CLLocationManager().requestWhenInUseAuthorization()}
    }
}

#Preview {
    BuildingsMapView(buildings: .constant(Building.sampleBuildings))
}
