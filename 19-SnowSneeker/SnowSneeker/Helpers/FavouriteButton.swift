//
//  FavouriteButton.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import SwiftUI

struct FavouriteButton: View {
    
    @EnvironmentObject var modelData: ModelData
    @EnvironmentObject var favourites: Favourites
    var resort: Resort
    
    var body: some View {
        Button{
            if favourites.contains(resort){
                favourites.remove(resort)
            } else {
                favourites.add(resort)
            }
        } label: {
            Label("Favourite", systemImage: favourites.contains(resort) ? "star.fill" : "star")
                .labelStyle(.iconOnly)
                .foregroundColor(favourites.contains(resort) ? .yellow : .gray)
        }
    }
}

struct FavouriteButton_Previews: PreviewProvider {
    
    static var modelData = ModelData()
    
    static var previews: some View {
        FavouriteButton(resort: ModelData().resorts[0])
            .environmentObject(ModelData())
            .environmentObject(Favourites())
    }
}
