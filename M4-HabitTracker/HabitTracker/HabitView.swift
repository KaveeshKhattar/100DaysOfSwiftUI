//
//  HabitView.swift
//  HabitTracker
//
//  Created by Kaveesh Khattar on 17/06/22.
//

import SwiftUI

struct HabitView: View {
    
    var habit: Habit
    @State private var counter = 0
    
    var body: some View {
            VStack{
                Image(systemName: habit.emoji)
                    .font(.largeTitle)
                    .padding()
                    .background(Habit.stringToColor(string: habit.background).opacity(0.6))
                    .clipShape(Circle())
                    
                Spacer()
                
                                    
                        
                    
                    VStack{
                        Text("\(habit.streak)")
                            .padding()
                                                
                        VStack{
                            Image(systemName: "flame")
                                .font(.largeTitle)
                                .padding()
                        }
                        .padding()
                        .background(Habit.stringToColor(string: habit.background))
                        .clipShape(RoundedRectangle(cornerRadius: 0))
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Habit.stringToColor(string: habit.background).opacity(0.75), lineWidth: 6))
                
                    
                Spacer()
                
                
                    Button{
                        // add streak
                    } label: {
                        Image(systemName: "plus")
                            .font(.largeTitle)
                            .padding()
                            
                            .background(Habit.stringToColor(string: habit.background).opacity(0.6))
                            .clipShape(Circle())
                    }                                        
                    
                
                
            }
            .navigationTitle(habit.name)
        
    }
}

struct HabitView_Previews: PreviewProvider {
    static var previews: some View {
        HabitView(habit: Habit(id: UUID(), name: "Walk", emoji: "figure.walk", background: "Color.yellow", streak: 0))
    }
}
