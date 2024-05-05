//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kaveesh Khattar on 11/06/22.
//

import SwiftUI

struct ContentView: View {
    
    let options = ["Rock", "Paper", "Scissors", "Paper", "Scissors"]
    let imageArray = ["globe.americas", "newspaper", "scissors"]
    let winLoseArray = ["Win", "Lose", "Lose", "Win", "Lose", "Lose"]
    @State private var currentOption = Int.random(in: 0...4)
    @State private var winOrLose = Int.random(in: 0...1)
    @State private var score: Int = 0
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false
    @State private var numberOfQuestions: Int = 0
    @State private var totalQuestions: Int = 3
    
    func tapped(_ number: Int){
        
        // Rock - Wins
        if(currentOption == 0 && winOrLose == 0){
            if(number == 1){
                alertTitle = "Correct"
                alertMessage = "Yay"
                score += 1
            }
            else if (number == 0){
                alertTitle = "Wrong"
                alertMessage = "Oops! That's a tie"
            }
            else{
                alertTitle = "Wrong"
                alertMessage = "Oops! No points"
            }
        }
        
        // Rock - Loses
        else if(currentOption == 0 && winOrLose == 1){
            if(number == 2){
                alertTitle = "Correct"
                alertMessage = "Yay"
                score += 1
            }
            else if (number == 0){
                alertTitle = "Wrong"
                alertMessage = "Oops! That's a tie"
            }
            else{
                alertTitle = "Wrong"
                alertMessage = "Oops! No points"
            }
        }
        
        // Paper - Wins
        if(currentOption == 1 && winOrLose == 0){
            if(number == 2){
                alertTitle = "Correct"
                alertMessage = "Yay"
                score += 1
            }
            else if (number == 1){
                alertTitle = "Wrong"
                alertMessage = "Oops! That's a tie"
            }
            else{
                alertTitle = "Wrong"
                alertMessage = "Oops! No points"
            }
        }
        
        // Paper - Loses
        else if(currentOption == 1 && winOrLose == 1){
            if(number == 0){
                alertTitle = "Correct"
                alertMessage = "Yay"
                score += 1
            }
            else if (number == 1){
                alertTitle = "Wrong"
                alertMessage = "Oops! That's a tie"
            }
            else{
                alertTitle = "Wrong"
                alertMessage = "Oops! No points"
            }
        }
        
        // Scissors - Wins
        if(currentOption == 2 && winOrLose == 0){
            if(number == 0){
                alertTitle = "Correct"
                alertMessage = "Yay"
                score += 1
            }
            else if (number == 2){
                alertTitle = "Wrong"
                alertMessage = "Oops! That's a tie"
            }
            else{
                alertTitle = "Wrong"
                alertMessage = "Oops! No points"
            }
        }
        
        // Scissors - Loses
        else if(currentOption == 2 && winOrLose == 1){
            if(number == 1){
                alertTitle = "Correct"
                alertMessage = "Yay"
                score += 1
            }
            else if (number == 2){
                alertTitle = "Wrong"
                alertMessage = "Oops! That's a tie"
            }
            else{
                alertTitle = "Wrong"
                alertMessage = "Oops! No points"
            }
        }
        
        showingAlert = true
        numberOfQuestions += 1
    }
    
    func newGame(){
        currentOption = Int.random(in: 0...5)
        winOrLose = Int.random(in: 0...1)
    }
    
    var body: some View {
        
        VStack(spacing: 30){
            Text( numberOfQuestions == totalQuestions ? "Game Over" : "Rock, Paper and Scissors ")
                .font(.title.bold())
            HStack{
                Text( numberOfQuestions == totalQuestions ? "" : "How do you \(winLoseArray[winOrLose]) against \(options[currentOption])")
                    .font(.headline.weight(.light))
            }
            
                                        
            ForEach(0...2, id: \.self){ number in
                Button{
                    tapped(number)
                } label: {
                    Image(systemName: imageArray[number])
                        .font(.largeTitle)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue))
                }
            }
            .disabled(numberOfQuestions == totalQuestions ? true : false)
            
            Text("Score: \(score)")
                .font(.headline.weight(.bold))
            
        }
        .alert(alertTitle, isPresented: $showingAlert){
            Button(alertTitle, action: newGame)
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
