//
//  Bundle-Decodable.swift
//  MoonshotAnotherAttempt
//
//  Created by Kaveesh Khattar on 18/10/21.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        
        // locating the file
        guard let locatedFile = self.url(forResource: file, withExtension: nil) else{
            fatalError("Could not locate \(file)")
        }
        
        // loading the file
        guard let loadingFile = try? Data(contentsOf: locatedFile) else{
            fatalError("Could not load \(file)")
        }
        
        // reading contents of file
        
        let decoder = JSONDecoder()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-d"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        
        guard let decoded = try? decoder.decode(T.self, from: loadingFile) else{
            fatalError("Could not read \(file)")
        }
        return decoded
    }
}
