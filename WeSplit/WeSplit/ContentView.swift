//
//  ContentView.swift
//  WeSplit
//
//  Created by Kaveesh Khattar on 19/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var totalBill = ""
    @State private var tipPercent = 2
    @State private var numberOfPeople = 2
    let tipArray = [0, 5, 10, 15, 20]
    var totalPerPerson: Double{
        
        let orderAmount = Double(totalBill) ?? 0
        let tipAmount = Double(tipArray[tipPercent])
        let tipValue = orderAmount*tipAmount/100
        let grandTotal = orderAmount + tipValue
        
        return grandTotal/Double(numberOfPeople+2)
    }
    
    var billWithTax: Double{
        
        let orderAmount = Double(totalBill) ?? 0
        let tipAmount = Double(tipArray[tipPercent])
        let tipValue = orderAmount*tipAmount/100
        let grandTotal = orderAmount + tipValue
        
        return grandTotal
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    TextField("Enter total bill amount", text: $totalBill)
                        .keyboardType(.decimalPad)
                }
                
                Section{
                    Picker("Enter Tip Percentage", selection: $tipPercent){
                        ForEach(0..<tipArray.count){
                            Text("\(tipArray[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section{
                    Picker("Number of People", selection: $numberOfPeople){
                        ForEach(2..<20){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("Total Amount")){
                    Text("\(billWithTax, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount to be paid per person")){
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
