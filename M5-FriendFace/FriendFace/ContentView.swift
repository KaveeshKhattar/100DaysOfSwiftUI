//
//  ContentView.swift
//  FriendFace
//
//  Created by Kaveesh Khattar on 21/06/22.
//

import SwiftUI

struct Friend: Codable {
    var id: String
    var name: String
}

struct User: Codable {
    var id: String
    var isActive: Bool
    var name: String
    var age: Int
    var compnay: String
    var email: String
    var address: String
    var about: String
    var registered: String
    var tags: [String]
    var friends: [Friend]
}

struct Response: Codable{
    var users: [User]
}


struct ContentView: View {
    
    @State private var people = [User]()
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([User].self, from: data)
            people = decodedResponse
            
            
        } catch {
            print("Invalid Data")
        }
        
    }
             
    
    
    var body: some View {
        
        NavigationView{
            List(people, id: \.id){ person in
                Text(person.name)
            }
            .task{
                await loadData()
            }
            .navigationTitle("FriendFace")
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
