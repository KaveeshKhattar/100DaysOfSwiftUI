//
//  ColorCyclingRectangle.swift
//  Drawing
//
//  Created by Kaveesh Khattar on 31/10/21.
//

import SwiftUI

struct ColorCyclingRectangle: View {
    
    struct ColorCyclingRectangle: View{
        
        var amount = 0.0
        var steps = 100
        var startPoint: UnitPoint
        var endPoint: UnitPoint
        
        
        func color(for value: Int, brightness: Double) -> Color{
            var targetHue = Double(value)/Double(steps) + amount
            
            if targetHue>1{
                targetHue -= 1
            }
            
            return Color(hue: targetHue, saturation: 1, brightness: brightness)
        }
        
        var body: some View{
            ZStack{
                ForEach(0..<steps){ value in
                    Rectangle()
                        .inset(by: CGFloat(value))
                        .strokeBorder(LinearGradient(gradient: Gradient(colors: [self.color(for: value, brightness: 1), self.color(for: value, brightness: 0.5)]), startPoint: startPoint, endPoint: endPoint))
                }
            }
            .drawingGroup()
        }
    }
    
    private let unitPoints = [UnitPoint.top, UnitPoint.bottom, UnitPoint.leading, UnitPoint.trailing, UnitPoint.center]
    private let unitPointsName = ["Top", "Bottom", "Leading", "Trailing", "Center"]
    @State private var colorCycle = 0.0
    
    @State private var presentStart = 0
    @State private var presentEnd = 3
    
    var body: some View {
        VStack{
            ColorCyclingRectangle(amount: self.colorCycle, startPoint: unitPoints[presentStart], endPoint: unitPoints[presentEnd])
                .frame(width: 300, height: 300)
                .padding()
            
            Text("Change Color")
            Slider(value: $colorCycle)
                .padding()
            
            Text("Start Point")
            Picker("Start Point", selection: $presentStart){
                ForEach(0..<unitPoints.count){
                    Text(unitPointsName[$0])
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            
            
            Text("End Point")
            Picker("End Point", selection: $presentEnd){
                ForEach(0..<unitPoints.count){
                    Text(unitPointsName[$0])
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            
            
        }
        .padding()
    }
}

struct ColorCyclingRectangle_Previews: PreviewProvider {
    static var previews: some View {
        ColorCyclingRectangle()
    }
}
