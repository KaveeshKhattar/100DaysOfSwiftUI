//
//  ContentView.swift
//  Moonshot
//
//  Created by Kaveesh Khattar on 19/10/21.
//

import SwiftUI

struct ContentView: View {
    
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showingCrew = false
    
    
    
    var body: some View {
        NavigationView{
            List(missions){ mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: astronauts)){
                    HStack{
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                        
                        VStack(alignment: .leading){
                            Text(mission.displayName)
                            if(self.showingCrew){
                                Text(mission.showCrewNames(astronauts: self.astronauts))
                            }
                            else{
                                Text(mission.formattedLaunchDate)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Moonshot")
            .navigationBarItems(trailing: Button(self.showingCrew ? "Show Launch Date" : "Show Crew"){
                self.showingCrew.toggle()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
