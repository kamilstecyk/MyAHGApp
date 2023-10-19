//
//  BuildingTheme.swift
//  MyAHGApp
//
//  Created by Kamil Stecyk on 19/10/2023.
//

import SwiftUI

class BuildingThemeManager {
    static var currentTheme: Theme = .light

    enum Theme {
        case light
        case dark
    }

    // Funkcja do zmiany schematu kolorystycznego
    static func toggleTheme() {
        currentTheme = (currentTheme == .light) ? .dark : .light
    }

    // Mapowanie pomiędzy typami budynków a kolorami
    static func BackgroundColorForBuildingType(buildingType: BuildingType) -> Color {
        switch currentTheme {
        case .light:
            return colorForBuildingType(buildingType)
        case .dark:
            return colorForBuildingType(buildingType)
        }
    }

    // Funkcja do dostosowania koloru tekstu
    static func textColorForBuildingType(buildingType: BuildingType) -> Color {
        switch currentTheme {
        case .light:
            return .black
        case .dark:
            return .white
        }
    }

    static private func colorForBuildingType(_ buildingType: BuildingType) -> Color {
        switch buildingType {
        case .university:
            return Color("UniversityColor")
        case .library:
            return Color("LibraryColor")
        case .dormitory:
            return Color("DormitoryColor")
        default:
            return Color("OthersColor")
        }
    }
}

