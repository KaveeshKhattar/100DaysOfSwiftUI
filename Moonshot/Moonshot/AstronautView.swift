//
//  AstronautView.swift
//  MoonshotAnotherAttempt
//
//  Created by Kaveesh Khattar on 19/10/21.
//


import SwiftUI

struct AstronautView: View {
    
    let astronaut: Astronaut
    let missions: [Mission]
    
    
    init(astronaut: Astronaut){
        
        self.astronaut = astronaut
        var matches = [Mission]()
        let missions: [Mission] = Bundle.main.decode("missions.json")
                
        for mission in missions{
            if mission.crew.first(where: { $0.name == astronaut.id }) != nil {
                matches.append(mission)
            }
        }
        self.missions = matches
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical){
                Image(astronaut.id)
                    .resizable()
                    .frame(maxWidth: geometry.size.width)
                
                HStack{
                    ForEach(self.missions){ mission in
                        Image(mission.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                    }
                }
                
                Text(astronaut.description)
                    .padding()
            }
        }
        .navigationTitle(Text(astronaut.name))
    }
}

struct AstronautView_Previews: PreviewProvider {
    
    static var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
