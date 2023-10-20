//
//  Building.swift
//  MyAHGApp
//
//  Created by Guest User on 13/10/2023.
//

import Foundation
import MapKit

enum Status {
    case limited
    case yes
}

struct Building: Identifiable {
    let id: UUID
    let symbol: String
    let officialName: String
    let photo: Data?
    let address: String
    let characteristics: String
    let hasWifi: Status
    let hasWheelchairAccessibility: Status
    var isFavourite: Bool
    let shape: MKPolygon?
    let buildingType: BuildingType
    
    
    init(id: UUID = UUID(), symbol: String, officialName: String, photo: Data?, address: String, characteristics: String, hasWifi: Status, hasWheelchairAccessibility: Status, shape: MKPolygon, buildingType: BuildingType, isFavourite: Bool) {
        self.id = id
        self.symbol = symbol
        self.officialName = officialName
        self.photo = photo
        self.address = address
        self.characteristics = characteristics
        self.hasWifi = hasWifi
        self.hasWheelchairAccessibility = hasWheelchairAccessibility
        self.shape = shape
        self.buildingType = buildingType
        self.isFavourite = isFavourite;
    }
}

extension Building{
    static let sampleBuildings: [Building] = [
        Building(symbol: "D-9", officialName: "Budynek D-9", photo: nil, address: "Kawiory 40", characteristics: "Bardzo nowoczesny budynek w infrastrukturze AGH. Zobacz go na mapie, a nastepnie odwiedz go osobiscie. Czekamy na Ciebie!", hasWifi: Status.limited, hasWheelchairAccessibility: Status.yes, shape: {
            let coordinates: [[Double]] = [[19.9095386,50.0678058],[19.9095019,50.0676912],[19.9101476,50.0675934],[19.9101869,50.0677089],[19.9095386,50.0678058]]
            var points = [CLLocationCoordinate2D]()
            for cordinate in coordinates{
                let latitude = cordinate[1]
                let longitude = cordinate[0]
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                points.append(coordinate)
            }
            return MKPolygon(coordinates: &points, count: points.count)
        }(), buildingType: BuildingType.university, isFavourite: false),
        
        Building(symbol: "D-15", officialName: "Budynek D-15", photo: nil, address: "Nawojki 11", characteristics: "Cyfronet AGH", hasWifi: Status.yes, hasWheelchairAccessibility: Status.yes, shape: {
            let coordinates: [[Double]] = [[19.9088113,50.0689482],[19.9095192,50.0688447],[19.909557,50.0689519],[19.9095613,50.0689642],[19.9094081,50.0689866],[19.9088535,50.0690676],[19.9088113,50.0689482]]
            var points = [CLLocationCoordinate2D]()
            for cordinate in coordinates{
                let latitude = cordinate[1]
                let longitude = cordinate[0]
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                points.append(coordinate)
            }
            return MKPolygon(coordinates: &points, count: points.count)
        }(), buildingType: BuildingType.other, isFavourite: true)
    ]
}
