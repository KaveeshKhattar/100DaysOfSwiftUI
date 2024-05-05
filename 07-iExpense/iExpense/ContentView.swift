//
//  ContentView.swift
//  iExpense
//
//  Created by Kaveesh Khattar on 15/06/22.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items){
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Items"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
            }
        }
        
        items = []
    }
}

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingSheet = false
    
    func removeItems(at offsets: IndexSet){
        expenses.items.remove(atOffsets: offsets)
    }
    
    func decideForegroundColor(for amount: Double) -> Color {
        if(amount < 10) {
            return Color.green
        } else if(amount < 100) {
            return Color.yellow
        } else {
            return Color.red
        }
    }
    
    var body: some View {
        NavigationView{
            List{
                
                Section{
                    
                } header : {
                    Text("Personal")
                }
                
                ForEach(expenses.items){ item in
                    HStack {
                        VStack(alignment: .leading){
                            Text(item.name)
                            Text(item.type)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                            .foregroundColor(decideForegroundColor(for: item.amount))
                    }
                }
                .onDelete(perform: removeItems)
            }
            .navigationTitle("iExpense")
            .toolbar{
                Button{
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingSheet){
                AddView(expenses: expenses)
                    
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
