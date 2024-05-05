//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Kaveesh Khattar on 18/06/22.
//

import SwiftUI

@main
struct BookwormApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
