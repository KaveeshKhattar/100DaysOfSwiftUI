//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kaveesh Khattar on 19/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Germany", "Italy", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var titleDisplay = ""
    @State private var messageDisplay = ""
    @State private var userScore = 0
    @State private var showingAlert = false
    
    func tapped(_ number: Int){
        if number == correctAnswer{
            titleDisplay = "Correct"
            messageDisplay = "Score Boost"
            userScore += 1
        }
        else{
            titleDisplay = "Wrong"
            messageDisplay = "That is the flag of \(countries[number])"
            userScore += 0
        }
        showingAlert = true
    }
    
    func continueGame(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.orange, Color.blue, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 30){
                VStack{
                    Text("Tap the flag of")
                    Text("\(countries[correctAnswer])")
                        .font(.title)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                
                ForEach(0..<countries.count){number in
                    Button(action: {
                        tapped(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black))
                            .shadow(radius: 10)
                    }.alert(isPresented: $showingAlert){
                        Alert(title: Text(titleDisplay), message: Text(messageDisplay), dismissButton: .default(Text("Continue")){
                            self.continueGame()
                        }
                        )
                    }
                }
                Text("Score: \(userScore)")
                    .foregroundColor(.white)
                    .font(.title)
                    .fontWeight(.black)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
