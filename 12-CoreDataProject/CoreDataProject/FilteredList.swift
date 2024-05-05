//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Kaveesh Khattar on 21/06/22.
//

import SwiftUI

struct FilteredList: View {
    
    @FetchRequest var fetchRequest: FetchedResults<Singer>    
    
    init(predicate: String, filter: String, sortDescriptors: [SortDescriptor<Singer>]){
                        
        _fetchRequest = FetchRequest<Singer>(sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "lastName \(predicate) @", filter))
        
    }
    
    var body: some View {
        List(fetchRequest, id: \.self){ singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }
}
