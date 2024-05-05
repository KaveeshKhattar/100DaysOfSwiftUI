//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kaveesh Khattar on 11/06/22.
//

import SwiftUI

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var score: Int = 0
    @State private var numberOfQuestions: Int = 0
    
    @State private var animationAmount = [0.0, 0.0, 0.0]
    @State private var opacity = false
    @State private var animateSize = false
    
    
    func askQuestion(){
        if(numberOfQuestions != 8){
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            opacity = false
            animateSize = false
        }
        else{
            
        }
    }
    
    func flagTapped(_ number: Int){
        if(number == correctAnswer){
            score += 1
            numberOfQuestions += 1
            alertTitle = "Correct"
            alertMessage = "Yay"
            withAnimation{
                animationAmount[number] += 360
                animateSize = true
            }
        } else {
            alertTitle = "Wrong"
            numberOfQuestions += 1
            alertMessage = "That is the flag of \(countries[number])"
        }
        opacity = true
        showingAlert = true
    }
    
    var body: some View {
        
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
                                    
            VStack {
                
                Spacer()
                
                Text(numberOfQuestions == 8 ?  "Game Over" : "Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.white)
                
                VStack(spacing: 15){
                    VStack{
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundColor(.secondary)
                        Text("\(countries[correctAnswer])")
                            .font(.largeTitle.weight(.semibold))
                    }
                
                    ForEach(0..<3){ number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .modifier(FlagImage())
                        }
                        .rotation3DEffect(.degrees(animationAmount[number]), axis: (x: 0, y: 1, z: 0))
                        .opacity(opacity ? (number == correctAnswer ? 1 : 0.6) : 1 )
                        .scaleEffect( animateSize ? ( number == correctAnswer ? 1.3 : 1) : 1 )
                    }
                    .opacity(numberOfQuestions == 8 ? 0.4 : 1.0)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                Spacer()
            }
        }
        .alert(alertTitle, isPresented: $showingAlert){
            Button("OK", action: askQuestion)
        } message: {
            Text(alertMessage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
