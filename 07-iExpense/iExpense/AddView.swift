//
//  AddView.swift
//  iExpense
//
//  Created by Kaveesh Khattar on 15/06/22.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    let types = ["Work", "Personal"]
    @ObservedObject var expenses: Expenses
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Name of Purchase", text: $name)
                
                Picker("Select Type", selection: $type){
                    ForEach(types, id: \.self){ type in
                        Text(type)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationBarTitle("Add Expense")
            .toolbar{
                Button("Save"){
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
            
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
            .preferredColorScheme(.dark)
    }
}
