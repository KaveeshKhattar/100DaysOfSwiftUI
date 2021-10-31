//
//  Arrow.swift
//  Drawing
//
//  Created by Kaveesh Khattar on 31/10/21.
//

import SwiftUI

struct Arrow: View {
    
    // Challenge 1
    struct Arrow: Shape{
        
        var offset: CGFloat = 10.0
        var lineThickness: CGFloat
        var lineColor: Color
        
        func path(in rect: CGRect) -> Path{
            
            var path = Path()
            
            path.move(to: CGPoint(x: rect.width/2, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.width/2, y: rect.minY))
            
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + offset*15))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + offset*15))
            path.addLine(to: CGPoint(x: rect.width/2, y: rect.minY))
            // path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + offset*15))
            
            return path
        }
        
        var animatableData: CGFloat{
            get { lineThickness }
            set { self.lineThickness = newValue }
        }
    }
    
    @State private var lineThickness: CGFloat = 5.0
    @State private var lineColor = Color.red
    
    var body: some View {
        Arrow(lineThickness: lineThickness, lineColor: lineColor)
            .stroke(lineColor, style: StrokeStyle(lineWidth: lineThickness, lineCap: .round, lineJoin: .round))
            .padding()
            .onTapGesture {
                withAnimation{
                    self.lineThickness = CGFloat(10.0)
                }
            }
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow()
    }
}
