//
//  ContentView.swift
//  BetterRest
//
//  Created by Kaveesh Khattar on 12/06/22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    @State private var wakeUpTime = defaultWakeTime
    @State private var coffeeAmount: Int = 0
    @State private var sleepAmount: Double = 4

    
    func calculateBedtime() -> String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUpTime)
            
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour+minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount+1))
            
            let sleep = wakeUpTime - prediction.actualSleep
                    
            return sleep.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Something went wrong"
        }
    }
    
    var body: some View {
        NavigationView{
            Form{
                    Section{
                        DatePicker("Please Enter Time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                    } header: {
                        Text("Wake up time")
                    }
                    
                    Section{
                        Picker("Number of Cups of Coffee", selection: $coffeeAmount){
                            ForEach(1..<20){ number in
                                if(number == 1){
                                    Text("\(number) cup")
                                } else {
                                    Text("\(number) cups")
                                }
                            }
                        }
                        .labelsHidden()
                    } header: {
                        Text("Cups of Coffee")
                    }
                    
                    Section{
                        Stepper(value: $sleepAmount, in: 4...12, step: 0.25){
                            Text("\(sleepAmount, specifier: "%g") hours")
                        }
                    } header: {
                        Text("Hours of Sleep")
                    }
                Section{
                    Text("\(calculateBedtime())")
                } header: {
                    Text("Bedtime")
                }
                                        
                }
                .navigationTitle("BetterRest")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
