//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Kaveesh Khattar on 20/06/22.
//

import SwiftUI

struct EmojiRatingView: View {
    
    let rating: Int16
    
    var body: some View {
        switch(rating){
        case 1:
            Text("1")
        case 2:
            Text("2")
        case 3:
            Text("3")
        case 4:
            Text("4")
        default:
            Text("5")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(rating: 3)
    }
}
