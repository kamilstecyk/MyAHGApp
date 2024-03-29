//
//  BuildingStore.swift
//  MyAHGApp
//
//  Created by Kamil Stecyk on 09/11/2023.
//

import SwiftUI

@MainActor
class BuildingStore: ObservableObject {
    @Published var buildings: [Building] = [];
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask,
                                            appropriateFor: nil,
                                            create: false)
                                            .appendingPathComponent("buildings.data")
    }
    
    func updateBuildings(buildingsData: [Building]) {
        self.buildings = buildingsData
    }
    
    func load() async throws {
        
        let fileURL = try Self.fileURL()
        print(fileURL)
        
        let task = Task<[Building], Error> {
            do {
                    guard let fileURL = try? Self.fileURL() else {
                        return []
                    }
                    
                    guard let data = try? Data(contentsOf: fileURL) else {
                        return []
                    }
                                        
                    let buildingsDecoded = try JSONDecoder().decode([Building].self, from: data)
                    
                    print("Got decoded Buildings from file successfully!")
//                    print(buildingsDecoded)
                    
                    return buildingsDecoded
                } catch {
                    print("Error: \(error)")
                    return []
                }
        }
        
        let buildingsResults = try await task.value
        
//        let buildingsResults: [Building] = []
                
        if(buildingsResults.isEmpty)
        {
            fetchDataFromAPI() { result in
                    switch result {
                            case .success(let buildings):
                                print("Fetched buildings succesfully")
                                self.buildings = buildings
                                return
                            case .failure(let error):
                                print("Error fetching data:", error)
                        }
            
                    }
        }
        
        self.buildings = buildingsResults
    }
    
    func save(buildings: [Building]) async throws {
           let task = Task {
               let data = try JSONEncoder().encode(buildings)
               let outfile = try Self.fileURL()
               try data.write(to: outfile)
           }
        _ = try await task.value
    }
    
    func fetchDataFromAPI(completion: @escaping (Result<[Building], Error>) -> Void) {
            guard let url = URL(string: "https://tools.sokoloowski.pl/pum-api/") else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }

            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode([Building].self, from: data)
                    print("Got decoded data initially from API successfully: ", decodedData)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    
    func refreshDataFetchingFromAPI() -> Void {
        guard let url = URL(string: "https://tools.sokoloowski.pl/pum-api/") else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let decodedData = try JSONDecoder().decode([Building].self, from: data)
                self.buildings = decodedData
                print("Got refreshed data from API successfully!");
            } catch {
            }
        }.resume()
    }
}
