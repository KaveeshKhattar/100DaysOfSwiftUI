//
//  ResortSpecsView.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import SwiftUI

struct ResortSpecsView: View {
    
    var resort: Resort
    
    var resortSize: String {
        switch(resort.size){
        case 1:
            return "Small"
        case 2:
            return "Medium"
        default:
            return "Large"
        }
    }
    
    var price: String {
        String(repeating: "$", count: resort.price)
    }
    
    var body: some View {
        Group{
            
            VStack{
                Text("Price")
                    .font(.caption.bold())
                Text(price)
                    .font(.title3)
            }
            VStack{
                Text("Size")
                    .font(.caption.bold())
                Text("\(resortSize)")
                    .font(.title3)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

struct ResortSpecsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ResortSpecsView(resort: ModelData().resorts[0])
    }
}
