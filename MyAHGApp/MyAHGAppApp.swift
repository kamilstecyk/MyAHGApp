//
//  MyAHGAppApp.swift
//  MyAHGApp
//
//  Created by Guest User on 06/10/2023.
//

import SwiftUI

@main
struct MyAHGAppApp: App {
    @StateObject private var store = BuildingStore()
    
    var body: some Scene {
        WindowGroup {
            TabView{
                BuildingsView(buildings: $store.buildings)
                {
                    Task {
                        do {
                            try await store.save(buildings: store.buildings)
                        } catch {
                            fatalError(error.localizedDescription)
                        }
                    }
                }.tabItem { Image(systemName: "building.2.fill") }
                
                BuildingsMapView(buildings: $store.buildings).tabItem { Image(systemName: "map.fill") }
            }
            .task {
                do {
                    try await store.load()
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
            .environmentObject(store)
        }
    }
}
