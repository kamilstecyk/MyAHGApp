//
//  ContentView.swift
//  MyAHGApp
//
//  Created by Guest User on 06/10/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(.AGH)
                .resizable()
                .aspectRatio(contentMode: .fit).frame(maxWidth: 300, maxHeight: 150).clipped()
                
            Text("Budynek A-0").multilineTextAlignment(.center).padding(1)
            Text("Dom studencki Olimp").multilineTextAlignment(.center)
            Text("Mickiewicza 30").multilineTextAlignment(.center)
            Text("To jest najstarszy budynek nasze pieknej uczelni").multilineTextAlignment(.center).padding(5)
            Image(.aghMapa)
            Image(systemName: "figure.roll")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
