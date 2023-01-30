//
//  AddresView.swift
//  CupcakeCorner
//
//  Created by Sander Haug on 28/01/2023.
//

import SwiftUI

struct AddresView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip", text: $order.zip)
            }
            Section {
                NavigationLink {
                    CheckOutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.hasValidAddress == false)
        }
        .navigationTitle("Delivery Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct addresView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddresView(order: Order())
        }
    }
}
