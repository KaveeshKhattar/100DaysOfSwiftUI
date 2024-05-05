//
//  DetailView.swift
//  Bookworm
//
//  Created by Kaveesh Khattar on 20/06/22.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    let book: Book
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let dateFormatter = DateFormatter()    
    
    func deleteBook(){
        moc.delete(book)
        
        try? moc.save()
        dismiss()
    }
    
    var body: some View {
        ScrollView{
            ZStack(alignment: .bottomTrailing){
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                
                Text(book.genre?.uppercased() ?? "FANTASY")
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(Capsule())
            }
            Text(book.author ?? "Unknown Author")
                .font(.title)
                .foregroundColor(.secondary)
            
            Text(book.review ?? "No Review")
                .padding()
            
            RatingView(rating: .constant(Int(book.rating)))
                .font(.largeTitle)
            
            Text(book.dateAdded?.formatted(date: .abbreviated, time: .shortened) ?? "01/01/2001")
                .font(.title)
            
            .navigationTitle(book.title ?? "Unknown Book")
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert("Delete Book", isPresented: $showingDeleteAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                    showingDeleteAlert = true
                } label: {
                    Label("Delete this book", systemImage: "trash")
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test Book"
        book.author = "Test Author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book"
        
        return NavigationView{
            DetailView(book: book)
        }
    }
}
