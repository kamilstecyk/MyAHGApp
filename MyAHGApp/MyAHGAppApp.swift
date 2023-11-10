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
            BuildingsView(buildings: $store.buildings)
                {
                    Task {
                            do {
                                try await store.save(buildings: store.buildings)
                            } catch {
                                fatalError(error.localizedDescription)
                            }
                            }
                        }
                .task {
                    do {
                        try await store.load()
                    } catch {
                        fatalError(error.localizedDescription)
                    }
                }
        }
    }
}
