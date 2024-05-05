//
//  ContentView.swift
//  Bookworm
//
//  Created by Kaveesh Khattar on 18/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title)
    ]) var books: FetchedResults<Book>
    @State private var showingAddScreen = false
    
    func deleteBooks(at offsets: IndexSet){
        for offset in offsets{
            // find the book in our fetch request
            let book = books[offset]
            
            // delete it from the context
            moc.delete(book)
        }
        
        // save the context
        try? moc.save
    }
    
    var body: some View {
        NavigationView{
            List{
                ForEach(books){ book in
                    
                    NavigationLink{
                        DetailView(book: book)
                    } label: {
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading){
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                    .foregroundColor(book.rating > 1 ? Color.primary : Color.red)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    
                }
                .onDelete(perform: deleteBooks)
            }
                .navigationTitle("BookWorm")
                .toolbar{
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button{
                            showingAddScreen.toggle()
                        } label: {
                            Label("Add Book", systemImage: "plus")
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading){
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddScreen){
                    AddBookView()
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
