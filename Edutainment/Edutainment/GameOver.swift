//
//  GameOver.swift
//  Edutainment
//
//  Created by Kaveesh Khattar on 07/11/21.
//

import SwiftUI

struct GameOver: View {
    var body: some View {
        VStack{
            Text("Game Over")
            Text("Game Over")
                .font(.title)
                .frame(width: 300, height: 50)
                .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .foregroundColor(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
        }
    }
}

struct GameOver_Previews: PreviewProvider {
    static var previews: some View {
        GameOver()
    }
}
