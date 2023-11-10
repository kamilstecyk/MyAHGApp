//
//  ContentView.swift
//  MyAHGApp
//
//  Created by Guest User on 06/10/2023.
//

import SwiftUI
import MapKit

struct BuildingView: View {
    var imageName = "AGH"
    @Binding var building: Building

    var body: some View {
        GeometryReader { geometry in
            ScrollView{
                VStack {
                    
                    if let imageURL = building.photo {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                // Placeholder view while loading
                                ProgressView()
                            case .success(let image):
                                // Successfully loaded image
                                image
                                    .resizable()
                                    .aspectRatio(2/1, contentMode: .fit)
                            case .failure:
                                // Placeholder view on failure
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(2/1, contentMode: .fit)
                                    .foregroundColor(.gray)
                            @unknown default:
                                // Placeholder view for unknown cases
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(2/1, contentMode: .fit)
                                    .foregroundColor(.gray)
                            }
                        }
                    } else {
                        // Placeholder view when URL is nil
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(2/1, contentMode: .fit)
                            .foregroundColor(.gray)
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
                            Text(building.officialName ?? "Brak oficjalnej nazwy").multilineTextAlignment(.center)
                            
                            
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
                    
                    Text(building.characteristics).multilineTextAlignment(.center).padding(5).font(.system(size: 14))
                    
                    Map() {
                        MapPolygon(building.shape)
                    }.frame(width: geometry.size.width, height: geometry.size.width)
                    
                }
            }
        }.padding()
    }
}

#Preview {
    BuildingView(building: .constant(Building.sampleBuildings[0]))
}
