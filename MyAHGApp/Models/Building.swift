//
//  Building.swift
//  MyAHGApp
//
//  Created by Guest User on 13/10/2023.
//

import Foundation
import MapKit

enum Status: Codable {
    case limited
    case yes
}

struct Coordinate: Codable {
    var lat: CLLocationDegrees
    var lon: CLLocationDegrees
}

struct Building: Identifiable {
    let id: UUID
    let symbol: String
    let officialName: String?
    let photo: URL?
    let address: String
    let characteristics: String
    let hasWifi: Status
    let hasWheelchairAccessibility: Status
    var isFavourite: Bool
    let shape: MKPolygon?
    let buildingType: BuildingType
    
    let street: String
    let houseNumber: String
    let postcode: String
    let city: String
    
    enum CodingKeys: String, CodingKey {
            case symbol
            case name
            case wifi
            case wheelchair
            case floors
            case street
            case houseNumber
            case postcode
            case city
            case description
            case type
            case polygon
            case imageURL
            case isFavourite
    }
    
    init(id: UUID = UUID(), symbol: String, officialName: String, photo: URL?, address: String, characteristics: String, hasWifi: Status, hasWheelchairAccessibility: Status, shape: MKPolygon, buildingType: BuildingType, isFavourite: Bool) {
        self.id = id
        self.symbol = symbol
        self.officialName = officialName
        self.photo = photo
        self.address = address
        self.characteristics = characteristics
        self.hasWifi = hasWifi
        self.hasWheelchairAccessibility = hasWheelchairAccessibility
//        self.shape = shape
        self.buildingType = buildingType
        self.isFavourite = isFavourite;
        self.street = ""
        self.houseNumber = ""
        self.postcode = ""
        self.city = ""
        self.shape = nil
    }
}

extension Building: Decodable {
    init(from decoder: Decoder) throws {
        self.id = UUID()
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.symbol = try values.decode(String.self, forKey: .symbol)
        
        self.officialName = try? values.decode(String.self, forKey: .name);
    
        self.photo = try? values.decode(URL.self, forKey: .imageURL);
        
        self.street = try values.decode(String.self, forKey: .street)
        self.houseNumber = try values.decode(String.self, forKey: .houseNumber)
        self.postcode = try values.decode(String.self, forKey: .postcode)
        self.city = try values.decode(String.self, forKey: .city)
        
        self.address = self.street + " " + self.houseNumber + " , " + self.postcode + " " + self.city
        self.characteristics = try values.decode(String.self, forKey: .description)
        self.hasWifi = try values.decode(Bool.self, forKey: .wifi) ? Status.yes : Status.limited
        self.hasWheelchairAccessibility = try values.decode(String.self, forKey: .wheelchair) == "yes" ? Status.yes : Status.limited
        
        var buildingType: BuildingType = BuildingType.other
        
        let buildingTypeString = try values.decode(String.self, forKey: .type)
        
        if(buildingTypeString == "university")
        {
            buildingType = BuildingType.university
        }
        else if(buildingTypeString == "dormitory")
        {
            buildingType = BuildingType.dormitory
        }
        else if(buildingTypeString == "library")
        {
            buildingType = BuildingType.library
        }
        else
        {
            buildingType = BuildingType.other
        }
        
        self.buildingType = buildingType
        
        let isFav = try? values.decode(Bool.self, forKey: .isFavourite);
        self.isFavourite = isFav ?? false
        
        let coordinatesResponse = try values.decode([Coordinate].self, forKey: .polygon)
        let coordinate2DArray = coordinatesResponse.map { CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lon) }
        let polygon = MKPolygon(coordinates: coordinate2DArray, count: coordinate2DArray.count)
        self.shape = polygon
    }
}

extension Building: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(self.symbol, forKey: .symbol)
        try container.encode(self.officialName, forKey: .name)
        try container.encode(self.street, forKey: .street)
        try container.encode(self.postcode, forKey: .postcode)
        try container.encode(self.houseNumber, forKey: .houseNumber)
        try container.encode(self.city, forKey: .city)
        try container.encode(self.photo, forKey: .imageURL)
        
        let wifi = self.hasWifi == Status.yes
        try container.encode(wifi, forKey: .wifi)
        
        let wheelchair = self.hasWheelchairAccessibility == Status.yes ? "yes" : "limited"
        try container.encode(wheelchair, forKey: .wheelchair)
        
        try container.encode(self.characteristics, forKey: .description)
        try container.encode(self.isFavourite, forKey: .isFavourite)
        
        var buildingType: String = ""
                
        if(self.buildingType == BuildingType.university)
        {
            buildingType = "university"
        }
        else if(self.buildingType == BuildingType.dormitory)
        {
            buildingType = "dormitory"
        }
        else if(self.buildingType == BuildingType.library)
        {
            buildingType = "library"
        }
        else
        {
            buildingType = "other"
        }
        
        try container.encode(buildingType, forKey: .type)
        
        let encodedCoordinates = self.shape?.encodedCoordinates()
        try container.encode(encodedCoordinates, forKey: .polygon)
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
        }(), buildingType: BuildingType.other, isFavourite: true),
        
        Building(symbol: "B-6", officialName: "Budynek B-6", photo: nil, address: "Aleja Adama Mickiewicza 30", characteristics: "Jest to jeden z uczelnianych budynków AGH.", hasWifi: Status.yes, hasWheelchairAccessibility: Status.limited, shape: {
            let coordinates: [[Double]] = [[19.9164812,50.0663586],[19.9164024,50.0663772],[19.9163849,50.0663459],[19.9163046,50.066365],[19.9162148,50.0662058],[19.9164561,50.0661492],[19.9164805,50.0661928],[19.916468,50.0661956],[19.9165329,50.0663115],[19.9164638,50.0663273],[19.9164812,50.0663586]]
            
            var points = [CLLocationCoordinate2D]()
            for cordinate in coordinates{
                let latitude = cordinate[1]
                let longitude = cordinate[0]
                let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                points.append(coordinate)
            }
            return MKPolygon(coordinates: &points, count: points.count)
        }(), buildingType: BuildingType.university, isFavourite: true)
    ]
}

extension MKPolygon {
    func encodedCoordinates() -> [Coordinate] {
        var coordinates: [Coordinate] = []
        
        let pointCount = self.pointCount
        
        let pointsPointer = self.points()
        
        let buffer = UnsafeBufferPointer(start: pointsPointer, count: pointCount)
        
        coordinates = buffer.map { mapPoint in
            let coordinate = mapPoint.coordinate
            return Coordinate(lat: coordinate.latitude, lon: coordinate.longitude)
        }
        
        return coordinates
    }
}
