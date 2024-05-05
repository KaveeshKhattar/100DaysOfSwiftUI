//
//  ContentView.swift
//  Animation
//
//  Created by Kaveesh Khattar on 14/06/22.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    
    let amount: Double
    let anchor: UnitPoint
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}


struct ContentView: View {
    
//    @State private var foregroundColor = true
//    @State private var animationAmount = 1.0
//    @State private var animationAmount2 = 1.0
    
//    @State private var dragAmount = CGSize.zero
//    @State private var enabled = false
//    let name = Array("Kaveesh Khattar")
    
    @State private var isShowingRed = false
    
    var body: some View {
        
//        VStack(spacing: 30){
//            Button("Ola Feature") {
//            }
//            .padding(50)
//            .background(.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .overlay(
//                Circle()
//                    .stroke(.green)
//                    .scaleEffect(animationAmount)
//                    .animation(
//                        .easeOut(duration: 1.5)
//                            .repeatForever(autoreverses: false),
//                        value: animationAmount
//                    )
//            )
//            .onAppear{
//                animationAmount = 3
//            }
//
//            Button("Color change"){
//                foregroundColor.toggle()
//            }
//            .padding(50)
//            .foregroundColor(.white)
//            .background(foregroundColor ? Color.green : Color.blue)
//            .clipShape(Circle())
//            .animation(.default, value: foregroundColor)
//
//            Stepper("Scale Amount", value: $animationAmount2.animation(), in: 1...10)
//                Spacer()
//
//                Button("Tap Me"){
//                    animationAmount2 += 1
//                }
//                .padding(50)
//                .foregroundColor(.white)
//                .background(Color.orange)
//                .clipShape(Circle())
//                .scaleEffect(animationAmount2)
//                .animation(.default, value: animationAmount2)
//        }
        
        // Drag Card View
        
//        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 20))
//            .offset(dragAmount)
//            .gesture(
//                DragGesture()
//                    .onChanged { dragAmount = $0.translation }
//                    .onEnded { _ in
//                        withAnimation{
//                            dragAmount = .zero
//                        }
//                    }
//            )
        
        // Name Drag View
//        HStack{
//        ForEach(0..<name.count, id: \.self){ letter in
//                Text(String(name[letter]))
//                .padding(5)
//                .background(enabled ? Color.red : Color.blue)
//                .offset(dragAmount)
//                .animation(.default.delay(Double(letter)/10), value: dragAmount)
//
//            }
//        .foregroundColor(.white)
//        .gesture(
//            DragGesture()
//                .onChanged { dragAmount = $0.translation }
//                .onEnded {
//                    _ in dragAmount = .zero
//                    enabled.toggle()
//                }
//        )
//        }
        
        // AnyTransition
        ZStack{
            Rectangle()
                .fill(.blue)
                .frame(width: 200, height: 200)
            
            if(isShowingRed){
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation{
                isShowingRed.toggle()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
