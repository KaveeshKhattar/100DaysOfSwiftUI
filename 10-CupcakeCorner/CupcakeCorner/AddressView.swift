//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Kaveesh Khattar on 03/05/22.
//

import SwiftUI

struct AddressView: View {
    
    @ObservedObject var order: Order    
    
    var body: some View {
        Form{
            Section{
                TextField("Name: ", text: $order.name)
                TextField("Street Address: ", text: $order.streetAddress)
                TextField("City: ", text: $order.city)
                TextField("Zip: ", text: $order.zip)
            }
            
            Section{
                NavigationLink(destination: CheckoutView(order: order)){
                    Text("Checkout")
                }
                .disabled(order.hasValidAddress == false)
            }
        }
        .navigationTitle(Text("Delivery Details"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
