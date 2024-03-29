//
//  ContentView.swift
//  BetterRest
//
//  Created by Kaveesh Khattar on 19/10/21.
//

import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date{
        var components = DateComponents()
        components.hour = 8
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }
    
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 1
    @State private var amountOfSleep = 8.0
    
    
    var calculateBedtime: String{
        let model = SleepCalculator()
        let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
        let hour = (components.hour ?? 0) * 60 * 60
        let minute = (components.minute ?? 0) * 60
        
        do{
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: amountOfSleep, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            
            return formatter.string(from: sleepTime)
        }
        catch{
            return "None"
        }
    }
    
    @State private var sleepAmount = ""
    
    var body: some View {
        
        NavigationView{
            Form{
                
                Section(header: Text("Wake Up Time")){
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                }
        
                Section(header: Text("Cups of Coffee")){
                    Stepper(value: $coffeeAmount, in: 1...20){
                        if(coffeeAmount == 1){
                            Text("1 cup")
                        }
                        else{
                            Text("\(coffeeAmount) cups")
                        }
                    }
                }
                
                Section(header: Text("Amount of Sleep")){
                    Stepper(value: $amountOfSleep, in: 4...12, step: 0.25){
                        Text("\(amountOfSleep, specifier: "%g") hours")
                    }
                }
                
                Section(header: Text("Bedtime")){
                    Text("\(calculateBedtime)")
                }
            }
            .navigationBarTitle("Better Rest")
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
