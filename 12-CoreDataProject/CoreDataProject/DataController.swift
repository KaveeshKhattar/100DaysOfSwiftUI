//
//  DataController.swift
//  CoreDataProject
//
//  Created by Kaveesh Khattar on 20/06/22.
//

import Foundation
import CoreData

class DataController{
    let container = NSPersistentContainer(name: "Singer")
    
    init(){
        container.loadPersistentStores{ description, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
        }
    }
}
