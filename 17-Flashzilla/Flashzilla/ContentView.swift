//
//  ContentView.swift
//  Flashzilla
//
//  Created by Kaveesh Khattar on 05/07/22.
//

import SwiftUI

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = Double(total - position)
        return self.offset(x: 0, y: offset*10)
    }
}

struct ContentView: View {
    
    @State private var cards = Array<Card>(repeating: Card.example, count: 10)
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    
    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = false
    
    
    
    func removeCards(at index: Int){
        cards.remove(at: index)
        
        if cards.isEmpty {
            isActive = false
        }
    }
    
    func resetCards() {
        cards = Array(repeating: Card.example, count: 10)
        timeRemaining = 100
        isActive = true
    }
    
    var body: some View {
        ZStack{ // background + VStack
            
            Image("background")
                .resizable()
                .ignoresSafeArea()
            
            VStack { // timer + cards
                
                Text("Time: \(timeRemaining)")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 5)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
                
                ZStack{ // cards
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]){
                            withAnimation{
                                removeCards(at: index)
                            }
                        }
                        .stacked(at: index, in: cards.count)
                    }
                }
                .allowsHitTesting(timeRemaining > 0)
                
                if cards.isEmpty{
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }
            
            if differentiateWithoutColor {
                VStack {
                    Spacer()
                    
                    HStack{
                        Image(systemName: "xmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                        
                        Spacer()
                        
                        Image(systemName: "checkmark.circle")
                            .padding()
                            .background(.black.opacity(0.7))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }
        .onReceive(timer){ time in
            
            guard isActive else { return }
            
            if timeRemaining > 0{
                timeRemaining -= 1
            }
        }
        .onChange(of: scenePhase){ newPhase in
            if newPhase == .active {
                if cards.isEmpty == false {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
