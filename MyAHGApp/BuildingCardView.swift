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
        VStack(alignment: .leading){
            Text(building.symbol).fontWeight(.heavy).font(.system(size: 22)).accessibilityAddTraits(.isHeader)
            HStack{
                Text(building.officialName)
                
                Spacer()
                                
                if building.hasWheelchairAccessibility == .limited {
                    Image(systemName: "figure.roll")
                        .foregroundColor(.gray)
                        .font(.system(size: 25))
                        .accessibility(label: Text("Wheelchair Icon"))
                } else if building.hasWheelchairAccessibility == .yes {
                    Image(systemName: "figure.roll")
                        .foregroundColor(.black)
                        .font(.system(size: 25)).accessibility(label: Text("Wheelchair Icon"))
                }
                
                if building.hasWifi == .limited {
                    Image(systemName: "wifi")
                        .foregroundColor(.gray)
                        .font(.system(size: 25)).accessibility(label: Text("Wi-Fi Icon"))
                } else if building.hasWifi == .yes {
                    Image(systemName: "wifi")
                        .foregroundColor(.black)
                        .font(.system(size: 25)).accessibility(label: Text("Wi-Fi Icon"))
                }
            }
        }.padding()
    }
}

#Preview {
    BuildingCardView(building: Building.sampleBuildings[0])
        .previewLayout(.fixed(width: 400, height: 60))
        .background(BuildingThemeManager.BackgroundColorForBuildingType(buildingType: Building.sampleBuildings[0].buildingType))
}

