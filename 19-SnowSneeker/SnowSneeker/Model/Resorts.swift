//
//  Resorts.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import Foundation
import CoreLocation

struct Resort: Identifiable, Hashable, Codable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var isFavourite: Bool
    private var coordinates: Coordinates
    var facilities: [String]
    
    
    var locationCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
    struct Coordinates: Codable, Hashable{
        var longitude: Double
        var latitude: Double
    }
}

extension Bundle {
    func load<T: Codable>(_ fileName: String) -> T {
        let data: Data
        
        guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
            fatalError("Could not locate \(fileName)")
        }
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            fatalError("Could not load from \(fileName)")
        }
                
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Could not parse data from \(fileName)")
        }
        
    }

}
