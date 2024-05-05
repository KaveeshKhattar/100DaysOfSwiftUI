//
//  ContentView.swift
//  HotProspects
//
//  Created by Kaveesh Khattar on 24/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var prospects = Prospects()
    
    var body: some View {
        TabView{
            ProspectsView(filter: .none)
                .tabItem{
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem{
                    Label("Contacted", systemImage: "checkmarked.circle")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem{
                    Label("Uncontacted", systemImage: "questionmarked.diamond")
                }
            
            MeView()
                .tabItem{
                    Label("Me", systemImage: "person.crop.square")
                }
        }
        .environmentObject(prospects)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
