//
//  ContentView.swift
//  iExpense
//
//  Created by Kaveesh Khattar on 19/10/21.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable{
    let id = UUID()
    let name: String
    let type: String
    let price: Double
}

class Expenses: ObservableObject{
    @Published var items = [ExpenseItem](){
        
        didSet{
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let items = UserDefaults.standard.data(forKey: "Items"){
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View{
    
    @ObservedObject var expenses = Expenses()
    @State private var showingAddExpense = false
    @State private var foregroundColourCheck = Color.white
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    func onRemove(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
    func priceStyles(num: Double) -> Color{
        if(num < 10){
            return Color.green
        }
        
        if(num < 100 && num > 10){
            return Color.orange
        }
        
        if(num > 100){
            return Color.red
        }
        return Color.white
    }
    
    func validation(text: String){
        if(text == "Human"){
            alertTitle = "Cannot perform this entry"
            alertMessage = "Calling the cops !!!"
        }
    }
    
    
    var body: some View{
        
        NavigationView{
            List{
                ForEach(expenses.items){ thing in
                    // Text(thing.name)
                    HStack{
                        VStack(alignment: .leading){
                            Text(thing.name)
                                .font(.headline)
                            Text(thing.type)
                                .font(.subheadline)
                        }
                        Spacer()
                                                
                        Text("$\(thing.price, specifier: "%g")")
                            .foregroundColor(priceStyles(num: thing.price))
                        
                    }
                }
                .onDelete(perform: onRemove)
            }
            .navigationTitle("iExpenses")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button(action:{
                        // let expenseExample = ExpenseItem(name: "example", type: "personal", price: 10)
                        // self.expenses.items.append(expenseExample)
                        self.showingAddExpense = true
                    }){
                        Image(systemName: "plus")
                    }
                    
                    EditButton()
                    
                }
                
            }
            .sheet(isPresented: $showingAddExpense){
                AddView(expenses: self.expenses)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


