//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Kaveesh Khattar on 17/08/21.
//

import SwiftUI

// titleStyle()
struct Title: ViewModifier{
    func body(content: Content) -> some View{
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .background(Color.blue)
    }
}

extension View{
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}

// Background modifier (done on my own)
struct Background: ViewModifier{
    func body(content: Content) -> some View{
        content
            .background(Color.orange)
            .foregroundColor(Color.white)
            .font(.title)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View{
    func contentStyle() -> some View{
        self.modifier(Background())
    }
}

// Watermark modifier

struct WaterMark: ViewModifier{
    
    var text = ""
    
    func body(content: Content) -> some View{
        ZStack(alignment: .bottomTrailing){
            content
            Text(text)
                .font(.caption)
                .foregroundColor(Color.white)
        }
    }
}


// extension for WaterMark modifier

extension View{
    func watery(with text: String) -> some View{
        self.modifier(WaterMark(text: text))
    }
}


// GridStack

struct GridStack<Content: View>: View{
    let rows: Int
    let columns: Int
    
    let content: (Int, Int) -> Content
    
    var body: some View{
        
        VStack{
            ForEach(0..<rows, id: \.self){row in
                HStack{
                    ForEach(0..<self.columns, id: \.self){column in
                        self.content(row, column)
                    }
                }
            }
        }
        
    }
}

// ContentView

struct ContentView: View {
    
    struct CapsuleText: View{
        var text: String
        
        var body: some View{
            Text(text)
                .font(.title)
                .padding()
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("What's up")
    
    var body: some View {
        NavigationView{
            Form{
                VStack(spacing: 20){
                    VStack{
                        CapsuleText(text: "I am derived from a struct")
                            .foregroundColor(Color.blue)
                        CapsuleText(text: "I am too, derived from a struct")
                        Text("Custom View Modifier")
                            .modifier(Title())
                    }
                    
                    VStack{
                        Text("Hello World, I am an extension of a modifier")
                            .titleStyle()
                        
                        motto1
                            .foregroundColor(Color.red)
                        motto2
                            .foregroundColor(Color.blue)
                    }
                    
                    Text("Hello, world!")
                        .frame(maxWidth: 200, maxHeight: 200)
                        .background(Color.red)
                    Text("Goodbye, world")
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 100)
                        .padding()
                        .background(Color.green)
                        .padding()
                        .background(Color.yellow)
                    VStack{
                        Text("Text 1")
                            .blur(radius: 1)
                        Text("Text 2")
                        Text("Text 3")
                        Text("Text 4")
                    }
                    .foregroundColor(.gray)
                    .blur(radius: 1)
                    // Environment Modifiers
                    
                    Text("My own modifier")
                        .contentStyle()
                    
                    Color.blue
                        .frame(width: 300, height: 100)
                        .watery(with: "Made with ❤️ by Kaveesh Khattar")
                    
                    GridStack(rows: 4, columns: 4){row, col in
                        Text("R\(row) C\(col)")
                    }
                    
                    GridStack(rows: 4, columns: 4){row, col in
                        HStack{
                            Image(systemName: "\(row*4 + col).circle")
                            Text("R\(row) C\(col)")
                        }
                    }
                }
            }
            .navigationBarTitle("Views/Modifiers")
        }
    }
}
        

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
