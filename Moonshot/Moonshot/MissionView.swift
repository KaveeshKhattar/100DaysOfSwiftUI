//
//  MissionView.swift
//  MoonshotAnotherAttempt
//
//  Created by Kaveesh Khattar on 19/10/21.
//



import SwiftUI

struct MissionView: View {
    
    let mission: Mission
    
    struct CrewMember{
        let role: String
        let astronaut: Astronaut
    }
    
    let astronauts: [CrewMember]
    
    init(mission: Mission, astronauts: [Astronaut]){
        self.mission = mission
        
        var matchedAstronauts = [CrewMember]()
        
        for member in mission.crew{
            if let matchedAstronaut = astronauts.first(where: { $0.id == member.name }){
                matchedAstronauts.append(CrewMember(role: member.role, astronaut: matchedAstronaut))
            }
        }
        self.astronauts = matchedAstronauts
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ScrollView(.vertical){
                Image(mission.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: geometry.size.width)
                    .padding(.top)
                
                Text(mission.formattedLaunchDate)
                    .foregroundColor(Color.secondary)
                    .padding()
                
                Text(mission.description)
                    .padding()
                
                ForEach(self.astronauts, id: \.role){ crewMember in
                    NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)){
                        HStack{
                            Image(crewMember.astronaut.id)
                                .resizable()
                                .frame(width: 80, height: 63)
                                .clipShape(Capsule())
                                .overlay(Capsule().stroke(Color.secondary, lineWidth: 1))
                            
                            VStack(alignment: .leading){
                                Text(crewMember.astronaut.name)
                                    .font(.headline)
                                Text(crewMember.role)
                                    .font(.subheadline)
                            }
                            Spacer()
                        }
                        .padding(.horizontal)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer(minLength: 25)
            }
        }
        .navigationTitle(Text(mission.displayName))
    }
}

struct MissionView_Previews: PreviewProvider {
    
    static var missions: [Mission] = Bundle.main.decode("missions.json")
    static var astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
