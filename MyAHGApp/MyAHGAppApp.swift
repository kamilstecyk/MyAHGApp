//
//  MyAHGAppApp.swift
//  MyAHGApp
//
//  Created by Guest User on 06/10/2023.
//

import SwiftUI

@main
struct MyAHGAppApp: App {
    @State private var buildings = Building.sampleBuildings
    
    var body: some Scene {
        WindowGroup {
            BuildingsView(buildings: $buildings)
        }
    }
}
