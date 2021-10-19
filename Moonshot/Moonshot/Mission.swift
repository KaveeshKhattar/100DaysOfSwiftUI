//
//  Mission.swift
//  MoonshotAnotherAttempt
//
//  Created by Kaveesh Khattar on 18/10/21.
//

import Foundation

struct Mission: Codable, Identifiable {
    let id: Int
    let launchDate: Date?
    
    struct Crew: Codable{
        let name: String
        let role: String
    }
    
    let crew: [Crew]
    let description: String
    
    var displayName: String{
        "Apollo \(id)"
    }
    
    var imageName: String{
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        if let launchDate = launchDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .long
            return formatter.string(from: launchDate)
        } else{
            return "N/A"
        }
    }
    
    func showCrewNames(astronauts: [Astronaut], separator: Character = "\n") -> String{
        
        var crewNames = ""
        
        for member in crew {
            if let match = astronauts.first(where: { $0.id == member.name }){
                crewNames += match.name + String(separator)
            } else {
                fatalError("Could not find \(member.name)")
            }
        }
        return crewNames
    }
    
}
