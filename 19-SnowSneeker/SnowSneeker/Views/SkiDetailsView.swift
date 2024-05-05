//
//  SkiDetailsView.swift
//  SnowSneeker
//
//  Created by Kaveesh Khattar on 01/07/22.
//

import SwiftUI

struct SkiDetailsView: View {
    
    var resort: Resort
    
    var body: some View {
        
            Group{
                    VStack{
                        Text("Elevation")
                            .font(.caption.bold())
                        Text("\(resort.elevation) m")
                            .font(.title3)
                    }
                    
                    VStack{
                        Text("Snow")
                            .font(.caption.bold())
                        Text("\(resort.snowDepth) cm")
                            .font(.title3)
                    }
                }
            .frame(maxWidth: .infinity)
    }
}

struct SkiDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        SkiDetailsView(resort: ModelData().resorts[0])
    }
}
