//
//  ResortDetailView.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import SwiftUI

struct ResortDetailView: View {
    
    @EnvironmentObject var modelData: ModelData
    var resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    @EnvironmentObject var favourites: Favourites
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var resortIndex: Int {
        modelData.resorts.firstIndex(where: { $0.id == resort.id })!
    }
    
    
    
    func imageName(for facility: String) -> String {
        
        switch(facility){
        case "Family":
            return "person.3.fill"
        case "Cross-country":
            return "globe.americas.fill"
        case "Accommodation":
            return "house.fill"
        case "Eco-friendly":
            return "leaf.fill"
        case "Beginners":
            return "01.circle.fill"
        default:
            return ""
        }
    }
    
    var body: some View {
        ScrollView{
            VStack{
                
                MapView(resort: resort)
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 300)
                
                VStack{
                    ZStack(alignment: .bottomTrailing){
                        Image(decorative: resort.id)
                            .resizable()
                            .scaledToFit()
                        
                        Text(resort.imageCredit)
                            .font(.caption)
                            .padding(4)
                            .background(Color.black)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .offset(x: 5, y: -5)
                    }
                    
                    HStack{
                        Text(resort.name)
                            .font(.title3.bold())
                        FavouriteButton(resort: resort)
                        
                        Spacer()
                        Text(resort.country)
                    }
                    .padding()
                }
                
                           
                
                HStack {
                    
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortSpecsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }                        
                    } else {
                        
                        SkiDetailsView(resort: resort)
                        ResortSpecsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                    
                
                
                
                VStack{
                    Text("Facilities")
                    Group{
                        HStack {
                            ForEach(resort.facilities, id: \.self){ facility in
                                VStack{
                                    Image(systemName: imageName(for: facility))
                                        .font(.title)
                                    Text(facility)
                                        .font(.caption)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .background(Color.primary.opacity(0.1))
                .frame(maxWidth: .infinity)
                
                Button(favourites.contains(resort) ? "Remove from Favourites" : "Add to Favourites"){
                    if favourites.contains(resort){
                        favourites.remove(resort)
                    } else {
                        favourites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
                
                Text(resort.description)
                    .padding()
            }
            .navigationBarTitle(resort.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ResortDetailView_Previews: PreviewProvider {
    
    static var resorts = ModelData().resorts
    
    static var previews: some View {
        ResortDetailView(resort: resorts[2])
            .environmentObject(ModelData())
            .environmentObject(Favourites())
            .previewInterfaceOrientation(.portrait)
    }
}
