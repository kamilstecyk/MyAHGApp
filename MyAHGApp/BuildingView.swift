//
//  ContentView.swift
//  MyAHGApp
//
//  Created by Guest User on 06/10/2023.
//

import SwiftUI

struct BuildingView: View {
    var imageName = "AGH"
    @State var building: Building

    var body: some View {
        ScrollView{
            VStack {
                if let image = UIImage(named: imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(2/1, contentMode: .fit)
                }
                HStack{
                    Text("Budynek " + building.symbol).font(.system(size: 30, weight: .bold)).frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                    
                    Spacer()
                    
                    Button(action: {
                        self.building.isFavourite.toggle()
                        }) {
                            Image(systemName: self.building.isFavourite ? "heart.fill" : "heart")
                                .font(.system(size: 30))
                                .foregroundColor(self.building.isFavourite ? .red : .gray)
                        }.padding(.trailing, 10).padding(.top, 5)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(building.officialName).multilineTextAlignment(.center)
                        
                        
                        Text(building.address).multilineTextAlignment(.center)
                    }.padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    
                    Spacer()
                    
                    if building.hasWheelchairAccessibility == .limited {
                        Image(systemName: "figure.roll")
                            .foregroundColor(.gray)
                            .font(.system(size: 25))
                            .accessibility(label: Text("Wheelchair Icon"))
                    } else if building.hasWheelchairAccessibility == .yes {
                        Image(systemName: "figure.roll")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                            .accessibility(label: Text("Wheelchair Icon"))
                    }
                    
                    if building.hasWifi == .limited {
                        Image(systemName: "wifi")
                            .foregroundColor(.gray)
                            .font(.system(size: 25))
                            .accessibility(label: Text("Wi-Fi Icon"))
                    } else if building.hasWifi == .yes {
                        Image(systemName: "wifi")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                            .accessibility(label: Text("Wi-Fi Icon"))
                    }
                }.padding(10)
                
                Text(building.characteristics).multilineTextAlignment(.center).lineLimit(4).padding(5).font(.system(size: 14))
                
                Image(.aghMapa).resizable().aspectRatio(1/1, contentMode: .fit)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    BuildingView(building: Building.sampleBuildings[0])
}
