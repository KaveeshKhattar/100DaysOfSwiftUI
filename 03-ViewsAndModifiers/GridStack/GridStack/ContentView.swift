//
//  ContentView.swift
//  GridStack
//
//  Created by Kaveesh Khattar on 20/08/21.
//

import SwiftUI


// VIEW MODIFIERS
struct Challenge: ViewModifier{
    func body(content: Content) -> some View{
        content
            .foregroundColor(.blue)
            .font(.largeTitle)
    }
}

extension View{
    func challengeFunc() -> some View{
        self.modifier(Challenge())
    }
}

// GRIDSTACK
struct GridStack<Content: View>: View{
    let rows: Int
    let cols: Int
    
    let content: (Int, Int) -> Content
    
    var body: some View{
        VStack{
            ForEach(0..<rows, id: \.self){row in
                HStack{
                    ForEach(0..<self.cols, id: \.self){col in
                        self.content(row, col)
                    }
                }
            }
        }
    }
}

// View Builders



// CONDITIONAL MODIFIERS

/*
struct ConditionalTitle: ViewModifier{
    func body(content: Content) -> some View{
        if()
    }
}
*/

struct FlagImageStruct: ViewModifier{
    func body(content: Content) -> some View{
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black))
            .shadow(radius: 10)
    }
}

extension View{
    func FlagImageFunc() -> some View{
        self.modifier(FlagImageStruct())
    }
}

struct ContentView: View {
    
    @State private var amount = ""
    @State private var tipPercent = 1
    var total: Double{
        let orderAmount = Double(amount) ?? 0
        let tipPercentage = Double(tipArray[tipPercent])
        let tipValue = (tipPercentage*orderAmount)/100
        let grandTotal = Double(orderAmount + tipValue)
        
        return grandTotal
    }
    
    let tipArray = [0, 5, 10, 15, 20]
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header: Text("Enter Amount")){
                    TextField("Enter: ", text: $amount)
                }
                Section(header: Text("Choose tip percent")){
                    Picker("Tip", selection: $tipPercent){
                        ForEach(0..<tipArray.count){
                            Text("\(tipArray[$0])")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Total Amount after tip")){
                    Text("\(total, specifier: "%.2f")")
                        .foregroundColor((tipArray[tipPercent] != 0) ? .black : .red)
                }
                
                Section(header: Text("GridStack")){
                    GridStack(rows: 2, cols: 2){row, col in
                        Image(systemName: "\(row*(row+1) + col).circle")
                    }
                }
                
                Section(header: Text("Challenge Function")){
                    Text("Welcome")
                        .challengeFunc()
                }
                
                Section(header: Text("Flag")){
                    Image("Germany")
                        .FlagImageFunc()
                }
            }
            .navigationBarTitle("GridStack Review")
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
