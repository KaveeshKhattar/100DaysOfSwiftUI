//
//  ContentView.swift
//  WeSplit
//
//  Created by Kaveesh Khattar on 11/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var amount = 0.0
    let arrayPercentages = [5, 10, 15, 20]
    @State private var tipPercent: Int = 5
    @State private var numberOfPeople = 1

    
    var total: Double {
        return amount + Double(tipPercent)*(amount/100)
    }
    
    var totalPerPerson: Double {
        return total/Double(numberOfPeople+2)
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Enter Amount")){
                    TextField("Enter Amount", value: $amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Choose Tip")){
                    Picker("Choose Tip", selection: $tipPercent){
                        ForEach(arrayPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                                
                
                Picker("Number of People", selection: $numberOfPeople){
                    ForEach(2..<100){
                        Text("\($0) people")
                    }
                }
                
                Section(header: Text("Total per Person")){
                    Text("\(totalPerPerson, specifier: "%.2f")")
                }
                
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
