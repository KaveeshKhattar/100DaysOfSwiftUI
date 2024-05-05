//
//  ContentView.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var favourites: Favourites
    
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: []) var resorts: FetchedResults<Resort>
    @State private var showingAddScreen = false

    
    @State private var searchText: String = ""
    
    var filteredResults: [Resort] {
        if searchText.isEmpty{
            return modelData.resorts
        } else {
            return modelData.resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(filteredResults, id: \.id){ resort in
                    NavigationLink{
                        ResortDetailView(resort: resort)
                    } label: {
                        Image(resort.country)
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(width: 40, height: 25)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(.black, lineWidth: 1))
                        
                        HStack{
                            VStack(alignment: .leading){
                                Text(resort.name)
                                Text("\(resort.runs) runs")
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Image(systemName: favourites.contains(resort) ? "star.fill" : "star")
                                .foregroundColor(favourites.contains(resort) ? .yellow : .gray)
                        }
                    }
                    .swipeActions(edge: .leading){
                        Button{
                            if favourites.contains(resort){
                                favourites.remove(resort)
                            } else {
                                favourites.add(resort)
                            }
                        } label: {
                            Label("Favourite", systemImage: "star.fill")
                        }
                        .tint(.yellow)
                    }
                }
            }
            .navigationBarTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for resorts")
            
            
            
            WelcomeView()
            
        }
        .phoneOnlyNavigationView()
        .environmentObject(favourites)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
            .environmentObject(Favourites())
            .previewInterfaceOrientation(.portrait)
    }
}
