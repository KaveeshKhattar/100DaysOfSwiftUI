//
//  WelcomeView.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack{
            Text("Welcome to SnowSneeker")
                .font(.largeTitle)
            
            Text("Please select a resort")
                .foregroundColor(.secondary)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
