//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Kaveesh Khattar on 20/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @State private var predicate = "BEGINSWITH"
    
    enum predicateList{
        case beginsWith, endsWith
    }
    
    var body: some View {
        VStack{
            FilteredList(predicate: predicate, filter: lastNameFilter, sortDescriptors: [SortDescriptor(\.firstName), SortDescriptor(\.lastName)])
            
            Button("Add Examples"){
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("A"){
                lastNameFilter = "A"
            }
            Button("S"){
                lastNameFilter = "S"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
