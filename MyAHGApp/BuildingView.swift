//
//  ContentView.swift
//  MyAHGApp
//
//  Created by Guest User on 06/10/2023.
//

import SwiftUI

struct BuildingView: View {
    var imageName = "AGH"
    var buildingSymbol = "A-0"
    var buildingName: String? = "A-0"
    var street = "Mickiewicza 30"
    var buildingDescription = "To jest charakterystyczny budynek naszej pięknej uczelni, chyba każdy go zna i każdy w nim był chociaż raz."
    var status: Status = .limited
    
    var body: some View {
        ScrollView{
            VStack {
                if let image = UIImage(named: imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(2/1, contentMode: .fit)
                }
                
                Text("Budynek " + buildingSymbol).font(.system(size: 30, weight: .bold)).frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                
                HStack {
                    VStack(alignment: .leading) {
                        if let name = buildingName { Text(name).multilineTextAlignment(.center)
                        }
                        
                        Text(street).multilineTextAlignment(.center)
                    }.padding(EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0))
                    Spacer()
                    if status == .limited {
                        Image(systemName: "figure.roll")
                            .foregroundColor(.gray)
                            .font(.system(size: 25))
                    } else if status == .yes {
                        Image(systemName: "figure.roll")
                            .foregroundColor(.black)
                            .font(.system(size: 25))
                    }
                }.padding(10)
                
                Text(buildingDescription).multilineTextAlignment(.center).lineLimit(4).padding(5)
                
                Image(.aghMapa).resizable().aspectRatio(1/1, contentMode: .fit)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    BuildingView()
}
