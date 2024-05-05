//
//  ContentView.swift
//  HabitTracker
//
//  Created by Kaveesh Khattar on 17/06/22.
//

import SwiftUI

struct Habit: Identifiable, Codable{
    var id = UUID()
    let name: String
    let emoji: String
    let background: String
    var streak: Int
        
    static func stringToColor(string: String) -> Color {
        switch(string){
        case "Color.red":
            return Color.red
        case "Color.orange":
            return Color.orange
        case "Color.yellow":
            return Color.yellow
        case "Color.green":
            return Color.green
        case "Color.blue":
            return Color.blue
        case "Color.purple":
            return Color.purple
        case "Color.pink":
            return Color.pink
        case "Color.indigo":
            return Color.indigo
        case "Color.brown":
            return Color.brown
        case "Color.gray":
            return Color.gray
        default:
            return Color.gray
        }
    }
}

class Habits: ObservableObject {
    @Published var allHabits = [Habit]() {
        didSet{
            if let encoded = try? JSONEncoder().encode(allHabits){
                UserDefaults.standard.set(encoded, forKey: "habits")
            }
        }                
    }
    
    init(){
        if let savedHabits = UserDefaults.standard.data(forKey: "habits"){
            if let decoded = try? JSONDecoder().decode([Habit].self, from: savedHabits){
                allHabits = decoded
            }
        }
        
        allHabits = []
        
    }
    
}

struct ContentView: View {
    
    @State private var showingSheet = false
    @StateObject var habitsFirstClass = Habits()
    
    var body: some View {
        NavigationView {
            VStack{
                List{
                    ForEach(habitsFirstClass.allHabits){ habit in
                        NavigationLink{
                            HabitView(habit: habit)
                        } label: {
                            HStack{
                                
                                Image(systemName: "\(habit.emoji)")
                                    .padding(8)
                                    .background(Habit.stringToColor(string: habit.background).opacity(0.4))
                                    .clipShape(Circle())
                                
                                Text("\(habit.name)")
                            
                            }
                        }
                    }
                }
                
                Spacer()
                
                Button{
                    showingSheet.toggle()
                } label: {
                    Text("Add Habit")
                }
            }
            .navigationTitle("My Habits")
            .toolbar{
                EditButton()
            }
            .sheet(isPresented: $showingSheet){
                SheetView(habitsClass: habitsFirstClass)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
