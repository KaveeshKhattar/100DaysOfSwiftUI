//
//  InsettableShape.swift
//  Drawing
//
//  Created by Kaveesh Khattar on 17/06/22.
//

import SwiftUI

struct InsettableShape: View {
    var body: some View {
        Circle()
            .strokeBorder(.blue, lineWidth: 40)
    }
}

struct InsettableShape_Previews: PreviewProvider {
    static var previews: some View {
        InsettableShape()
    }
}
