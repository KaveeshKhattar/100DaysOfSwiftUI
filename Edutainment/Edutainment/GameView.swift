//
//  GameView.swift
//  Edutainment
//
//  Created by Kaveesh Khattar on 06/11/21.
//

import SwiftUI

struct TextModifier: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.title)
            .padding()
            .foregroundColor(Color.white)
            .frame(width: 80, height: 70)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


extension View{
    func goldenStyle() -> some View{
        modifier(TextModifier())
    }
}

struct GameView: View {
    
    var thisNumbersTable: Int
    var numberOfQuestions: Int
    @State private var numberOfQuestionsDone: Int = 0
    
    @State private var userAnswer: String = ""
    @State private var userScore: Int = 0
    
    @State private var currentMultiplier: Int = Int.random(in: 0..<21)
    
    @State private var arrayForOptionsChoice: Array<Int> = [Int](0..<21)
    @State private var optionsPositionForAnswer: Int = Int.random(in: 0..<4)
    
    @State private var gameOver: Bool = false
    
    @State private var showingAlert: Bool = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @State private var toBeScaled: Int = -1
    @State private var wrongAnswerBackground: Int = -1
    
    @State private var scale: CGFloat = 1
    
    func newQuestionWithAnswerCorrect(){
        showingAlert.toggle()
        alertTitle = "Correct Answer"
        alertMessage = "Score Boost!"
                    
        userScore += 1
    }
    
    func newQuestionWithAnswerWrong(whichOptionChosen: Int, correctAnswer: Int){
        showingAlert.toggle()
        alertTitle = "Wrong Answer"
        alertMessage = "The answer is: \(thisNumbersTable*currentMultiplier)"
        
        
        wrongAnswerBackground = whichOptionChosen
        toBeScaled = correctAnswer
    }
    
    
    func newGame(){
        
        if(numberOfQuestionsDone == numberOfQuestions){
            gameOver = true
        }
        else{
            numberOfQuestionsDone += 1
            
            if(numberOfQuestionsDone == numberOfQuestions){
                gameOver = true
            }
            
            
            
            else{
                currentMultiplier = Int.random(in: 0..<21)
                optionsPositionForAnswer = Int.random(in: 0..<4)
            }
        }
        
        wrongAnswerBackground = -1
        toBeScaled = -1
    }
            
    
    var body: some View {
                
        VStack{
            
            Text("\(thisNumbersTable) X \(currentMultiplier)")
                .font(.title)
                .padding()
                .frame(width: 200, height: 70)
                .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .opacity(gameOver ? 0.5 : 1)
            
            VStack{
                HStack{
                    
                    Button(action: {
                        
                        if optionsPositionForAnswer == 0 {
                            newQuestionWithAnswerCorrect()
                            
                        }
                        else{
                            newQuestionWithAnswerWrong(whichOptionChosen: 0, correctAnswer: optionsPositionForAnswer)
                            newGame()
                        }
                    }){
                        Text(optionsPositionForAnswer == 0 ? "\(thisNumbersTable * currentMultiplier)" : "\(thisNumbersTable * (currentMultiplier + 2))")
                            .goldenStyle()
                    }
                    .disabled(gameOver ? true : false)
                    .background( wrongAnswerBackground == 0 ? LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .scaleEffect(toBeScaled == 0 ? 1.15 : 1)
                    .opacity(gameOver ? 0.5 : 1)
                    // .onTapGesture{
                        // withAnimation(Animation.default){
                            // scale = 1.15
                        // }
                    // }
                    // .alert(isPresented: $showingAlert){
                        // Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    // }
                                                                                
                    Button(action: {
                        if optionsPositionForAnswer == 1 {
                            newQuestionWithAnswerCorrect()
                        }
                        else{
                            newQuestionWithAnswerWrong(whichOptionChosen: 1, correctAnswer: optionsPositionForAnswer)
                        }
                    }){
                        Text(optionsPositionForAnswer == 1 ? "\(thisNumbersTable * currentMultiplier)" : "\(thisNumbersTable * (currentMultiplier + 1))")
                            .goldenStyle()
                    }
                    .disabled(gameOver ? true : false)
                    .background( wrongAnswerBackground == 1 ? LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .scaleEffect(toBeScaled == 1 ? 1.15 : 1)
                    .opacity(gameOver ? 0.5 : 1)
                    // .onTapGesture{
                        // withAnimation{
                            // scale = 1.15
                        // }
                    // }
                    // .alert(isPresented: $showingAlert){
                        // Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    // }
                }
                HStack{
                    
                    Button(action: {
                        if optionsPositionForAnswer == 2 {
                            newQuestionWithAnswerCorrect()
                        }
                        else{
                            newQuestionWithAnswerWrong(whichOptionChosen: 2, correctAnswer: optionsPositionForAnswer)
                        }
                    }){
                        Text(optionsPositionForAnswer == 2 ? "\(thisNumbersTable * currentMultiplier)" : "\(thisNumbersTable * (currentMultiplier - 1))")
                            .goldenStyle()
                            
                    }
                    .disabled(gameOver ? true : false)
                    .background( wrongAnswerBackground == 2 ? LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .scaleEffect(toBeScaled == 2 ? 1.15 : 1)
                    .opacity(gameOver ? 0.5 : 1)
                    // .onTapGesture{
                        // withAnimation{
                            // scale = 1.15
                        // }
                    // }
                    // .alert(isPresented: $showingAlert){
                        // Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    // }
                    
                    Button(action: {
                        if optionsPositionForAnswer == 3 {
                            newQuestionWithAnswerCorrect()
                        }
                        else{
                            newQuestionWithAnswerWrong(whichOptionChosen: 3, correctAnswer: optionsPositionForAnswer)
                        }
                    }){
                        Text(optionsPositionForAnswer == 3 ? "\(thisNumbersTable * currentMultiplier)" : "\(thisNumbersTable * (currentMultiplier - 2))")
                            .goldenStyle()
                    }
                    .disabled(gameOver ? true : false)
                    .background( wrongAnswerBackground == 3 ? LinearGradient(gradient: Gradient(colors: [Color.red, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing) : LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .scaleEffect(toBeScaled == 3 ? 1.15 : 1)
                    .opacity(gameOver ? 0.5 : 1)
                    // .onTapGesture{
                        // withAnimation{
                            // scale = 1.15
                        // }
                    // }
                    // .alert(isPresented: $showingAlert){
                        // Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    // }
                }
            }
            
            Text("Score : \(userScore)")
                .font(.title)
                .frame(width: 300, height: 50)
                .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            /*
            gameOver ? Text("Game Over")
                .font(.title)
                .frame(width: 300, height: 50)
                .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            : nil
             */
            
            Button(action: {
                newGame()
            }){
                gameOver ? nil : Text("Next Question")
                    .font(.title)
                    .frame(width: 300, height: 50)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .foregroundColor(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .disabled(gameOver ? true : false)
            
        }
        
        
        
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(thisNumbersTable: 0, numberOfQuestions: 1)
    }
}
