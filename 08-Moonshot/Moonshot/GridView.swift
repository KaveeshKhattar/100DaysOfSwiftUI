//
//  GridView.swift
//  Moonshot
//
//  Created by Kaveesh Khattar on 16/06/22.
//

import SwiftUI

struct GridView: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    @State private var showingGrid = true
    
    var body: some View {
        if(showingGrid){
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(missions) { mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            } label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()

                                    VStack {
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground)
                                )
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .toolbar{
                    ToolbarItem{
                        Button{
                            showingGrid.toggle()
                        } label: {
                            Text(showingGrid ? "List View" : "Grid View")
                                .foregroundColor(.white)
                        }
                        
                        if(showingGrid){
                            GridView(astronauts: astronauts, missions: missions)
                        } else{
                            ListView(astronauts: astronauts, missions: missions)
                        }
                    }
                }
            }
        } else {
            NavigationView{
                List{
                    ForEach(missions){ mission in
                        HStack{
                            VStack(alignment: .leading){
                                Text(mission.displayName)
                                    .font(.headline)
                                Text(mission.formattedDate)
                                    .font(.caption)
                            }
                            
                            Spacer()
                            
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                        }
                    }
                }
                .navigationBarTitle("Moonshot")
                .toolbar{
                    ToolbarItem{
                        Button{
                            showingGrid.toggle()
                        } label: {
                            Text(showingGrid ? "List View" : "Grid View")
                                .foregroundColor(.white)
                        }
                        
                        if(showingGrid){
                            GridView(astronauts: astronauts, missions: missions)
                        } else{
                            ListView(astronauts: astronauts, missions: missions)
                        }
                    }
                }
            }
        }
        
    }
}

struct GridView_Previews: PreviewProvider {
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        GridView(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}
