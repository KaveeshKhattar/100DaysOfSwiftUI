//
//  ContentView.swift
//  GuessTheFlagSolo
//
//  Created by Kaveesh Khattar on 17/08/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Germany", "Italy", "Monaco"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var titleDisplay = ""
    @State private var messageDisplay = ""
    @State private var userScore = 0
    @State private var showingAlert = false
    @State private var enabledRotation = false
    @State private var reduceOpacity = true
    @State private var rotations: [Double] = [0, 0, 0]
    @State private var opacities: [Double] = [1, 1, 1]
    @State private var scales: [CGFloat] = [1, 1, 1]
    
    func tapped(_ number: Int){
        
        for i in 0..<3 where i != correctAnswer {
            opacities[i] = 0.3
        }
        
        if number == correctAnswer{
            titleDisplay = "Correct"
            messageDisplay = "Score Boost"
            userScore += 1
            withAnimation{
                rotations[number] += 360
            }
        }
        else{
            titleDisplay = "Wrong"
            messageDisplay = "That is the flag of \(countries[number])"
            userScore += 0
            scales[number] = 0.3
        }
        showingAlert = true
        
        Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false){ _ in
            self.opacities = [1, 1, 1]
            self.continueGame()
            self.scales = [1, 1, 1]
        }
        
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
                        // rotate(number)
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black))
                            .shadow(radius: 10)
                    }
                    .alert(isPresented: $showingAlert){
                        Alert(title: Text(titleDisplay), message: Text(messageDisplay), dismissButton: .default(Text("Conitnue")))
                    }
                    .rotation3DEffect(.degrees(self.rotations[number]), axis: (x: 0, y: 1, z: 0))
                    .opacity(self.opacities[number])
                    .scaleEffect(self.scales[number], anchor: .center)
                    .animation(.easeInOut(duration: 1))
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
