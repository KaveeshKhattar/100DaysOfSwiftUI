//
//  ListView.swift
//  Moonshot
//
//  Created by Kaveesh Khattar on 16/06/22.
//

import SwiftUI

struct ListView: View {
    
    let astronauts: [String: Astronaut]
    let missions: [Mission]
        
    
    var body: some View {
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
        }
    }
}

struct ListView_Previews: PreviewProvider {
    
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    
    static var previews: some View {
        ListView(astronauts: astronauts, missions: missions)
            .preferredColorScheme(.dark)
    }
}
