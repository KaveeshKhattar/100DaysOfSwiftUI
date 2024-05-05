//
//  SnowSneekerApp.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import SwiftUI

@main
struct SnowSneekerApp: App {
    
    @StateObject var modelData = ModelData()
    @StateObject var favourites = Favourites()
    
    @StateObject private var dataContorller = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
                .environmentObject(favourites)
                .environment(\.managedObjectContext, dataContorller.container.viewContext)
        }
    }
}
