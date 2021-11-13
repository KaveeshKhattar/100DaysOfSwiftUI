//
//  ContentView.swift
//  Edutainment
//
//  Created by Kaveesh Khattar on 31/10/21.
//

import SwiftUI

// Button ViewModifier
struct ButtonDisplayer: ViewModifier{
                        
    func body(content: Content) -> some View{
        content
            .frame(width: 100, height: 50)
            .font(.title)
            .foregroundColor(Color.white)
    }
}

extension View{
    func buttonStyle() -> some View{
        modifier(ButtonDisplayer())
    }
}


struct ContentView: View {
    
    @State private var thisNumbersTable: Int = 1
    
    @State private var currentMultiplier: Int = Int.random(in: 0..<21)
    
    @State private var numberOfQuestions: Int = 0
    @State private var numberOfQuestionsArray: Array<Int> = [5, 10, 15, 20]
    
    @State private var lowerBound: Int = 0
    @State private var upperBound: Int = 20
        
    
    func incrementer(toBeIncremented: inout Int, lowerBound: Int, upperBound: Int){
        if(toBeIncremented < upperBound){
            toBeIncremented += 1
        }
    }
    
    func decrementer(toBeDecremented: inout Int, lowerBound: Int, upperBound: Int){
        if(toBeDecremented > lowerBound){
            toBeDecremented -= 1
        }
    }
    
    
    var body: some View{
        
        NavigationView{
            VStack(spacing: 10){
                
                Text("Multiplication Game")
                    .font(.largeTitle)
                    .frame(width: 350, height: 70)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.orange]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding()
                
                Text("\(thisNumbersTable)'s table")
                    .font(.title)
                    .frame(width: 200, height: 70)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack{
                    Button(action: {
                        incrementer(toBeIncremented: &thisNumbersTable, lowerBound: lowerBound, upperBound: upperBound)
                    }){
                        Text("+")
                            .buttonStyle()
                            .background(Color.green)
                            .clipShape(Capsule())
                            .padding(.bottom)
                    }
                    
                    Button(action: {
                        decrementer(toBeDecremented: &thisNumbersTable, lowerBound: lowerBound, upperBound: lowerBound)
                    }){
                        Text("-")
                            .buttonStyle()
                            .background(Color.red)
                            .clipShape(Capsule())
                            .padding(.bottom)
                    }
                }
                
                Text("\(numberOfQuestions) \(numberOfQuestions == 1 ? "question" : "questions")")
                    .font(.title)
                    .padding()
                    .frame(width: 200, height: 70)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.yellow]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack{
                    Button(action: {
                        incrementer(toBeIncremented: &numberOfQuestions, lowerBound: lowerBound, upperBound: upperBound)
                    }){
                        Text("+")
                            .buttonStyle()
                            .background(Color.green)
                            .clipShape(Capsule())
                            .padding(.bottom)
                    }
                    
                    Button(action: {
                        decrementer(toBeDecremented: &numberOfQuestions, lowerBound: lowerBound, upperBound: lowerBound)
                    }){
                        Text("-")
                            .buttonStyle()
                            .background(Color.red)
                            .clipShape(Capsule())
                            .padding(.bottom)
                    }
                }
                
                NavigationLink(destination: GameView(thisNumbersTable: thisNumbersTable, numberOfQuestions: numberOfQuestions)){
                    Text("Start Game")
                        .frame(width: 160, height: 160)
                        // .background(AngularGradient(gradient: Gradient(colors: [Color.red, Color.orange, Color.yellow, Color.green, Color.blue, Color.red]), center: .center))
                        .background(Color.blue)
                        .clipShape(Circle())
                        .foregroundColor(Color.white)
                        .font(.title)
                        .padding()
                        .opacity(numberOfQuestions != 0 ? 1 : 0.5)
                }
                .disabled(numberOfQuestions != 0 ? false : true)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
