//
//  Favourites.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import Foundation

class Favourites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favourites"
    
    init(){
        // load our saved data
        if let data = UserDefaults.standard.data(forKey: saveKey){
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                self.resorts = decoded
                return
            }
        }
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort){
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort){
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save(){
        // write out our data
        if let encoded = try? JSONEncoder().encode(resorts){
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    
}
