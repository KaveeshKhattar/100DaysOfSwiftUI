//
//  SheetView.swift
//  HabitTracker
//
//  Created by Kaveesh Khattar on 17/06/22.
//

import SwiftUI

struct SheetView: View {
    
    @Environment(\.dismiss) var dismiss
    let colors: [Color] = [
        Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.purple, Color.pink, Color.indigo, Color.brown, Color.gray
    ]
    
    func colorToString(color: Color) -> String{
        switch(color){
        case Color.red:
            return "Color.red"
        case Color.orange:
            return "Color.orange"
        case Color.yellow:
            return "Color.yellow"
        case Color.green:
            return "Color.green"
        case Color.blue:
            return "Color.blue"
        case Color.purple:
            return "Color.purple"
        case Color.pink:
            return "Color.pink"
        case Color.indigo:
            return "Color.indigo"
        case Color.brown:
            return "Color.brown"
        case Color.gray:
            return "Color.gray"
        default:
            return "Color.gray"
        }
    }
    
    let sfSymbols: [String] = ["figure.walk", "guitars", "sportscourt", "display", "gamecontroller"]        
    
    @State private var newHabit: String = ""
    @State private var currentSymbol: String = "figure.walk"
    @State private var currentBackground = Color.red
    @ObservedObject var habitsClass: Habits
    
    let columns = [GridItem(.adaptive(minimum: 65))]
    
    var body: some View {
        NavigationView{
            VStack{
                ZStack{
                    
                    Circle()
                        .frame(width: 75, height: 75)
                        .foregroundColor(currentBackground)
                    
                    Image(systemName: "\(currentSymbol)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
                .padding()
                
                TextField("New Habit", text: $newHabit)
                    .padding()
                    .background(.gray.opacity(0.1))

                VStack{
                    LazyVGrid(columns: columns){
                        ForEach(colors, id: \.self){ color in
                            Button{
                                currentBackground = color
                            } label: {
                                Circle()
                                    .frame(height: 40)
                                    .foregroundColor(color)
                            }
                            .padding(.bottom)
                        }
                    }

                    LazyVGrid(columns: columns){
                        ForEach(sfSymbols, id: \.self){ symbol in
                            Button{
                                currentSymbol = symbol
                            } label: {
                                ZStack{
                                    Circle()
                                        .foregroundColor(.gray.opacity(0.4))
                                        .frame(height: 55)

                                    Image(systemName: "\(symbol)")
                                        .font(.title)
                                        .foregroundColor(.white.opacity(0.75))
                                }
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
                
            }
            .navigationBarTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button{
                    habitsClass.allHabits.append(Habit(name: newHabit, emoji: currentSymbol, background: colorToString(color: currentBackground), streak: 0))
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
        }
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(habitsClass: Habits())
            .preferredColorScheme(.dark)
    }
}
