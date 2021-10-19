//
//  AddView.swift
//  iExpense
//
//  Created by Kaveesh Khattar on 19/10/21.
//

import SwiftUI

struct AddView: View {
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    
    let types = ["Work", "Personal"]
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    @ObservedObject var expenses: Expenses
    
    @Environment(\.presentationMode) var presentationMode
    
    func validation(text: String){
        if(text == "Human"){
            alertTitle = "Cannot perform this entry"
            alertMessage = "Calling the cops !!!"
            showingAlert.toggle()
        }
    }
    
    var body: some View {
        NavigationView{
            Form{
                TextField("Enter name of expense", text: $name)
                Picker("Type", selection: $type){
                    ForEach(types, id: \.self){
                        Text("\($0)")
                    }
                }
                TextField("Amount", text: $amount)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add Expense")
            .toolbar{
                ToolbarItemGroup{
                    Button("Done"){
                        if let actualAmount = Double(self.amount){
                            let item = ExpenseItem(name: self.name, type: self.type, price: actualAmount)
                            self.expenses.items.append(item)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                        validation(text: self.name)
                    }
                }
            }
            .alert(isPresented: $showingAlert){
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
