//
//  ContentView.swift
//  WordScramble
//
//  Created by Kaveesh Khattar on 13/06/22.
//

import SwiftUI

struct ContentView: View {
            
    @State private var rootWord: String = "silkworm"
    @State private var usedWords = [String]()
    @State private var newWord: String = ""
    
    @State private var score: Int = 0
    
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    @State private var showingAlert: Bool = false
    
    func startGame() {
        // find URL of start.txt
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            // load file into string
            if let startWords = try? String(contentsOf: startWordsURL){
                // split the string
                let allWords = startWords.components(separatedBy: "\n")
                // pick random or use default
                rootWord = allWords.randomElement() ?? "silkworm"
                
                return
            }
        }
        
        fatalError("Could not load start.txt")
    }
    
    func isNew(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool{
        let checker = UITextChecker()
        
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
        
    }
    
    func challenge1(word: String) -> Bool {
        if(word == rootWord){
            return false
        } else if (word.count <= 3){
            return false
        }
        
        return true
    }
    
    func wordError(title: String, message: String){
        alertTitle = title
        alertMessage = message
        showingAlert = true
    }
        
    
    func addNewWord() {
        
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard isNew(word: answer) else{
            wordError(title: "Oops", message: "Already used")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Oops", message: "Not possible")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Oops", message: "Not real")
            return
        }
        
        guard challenge1(word: answer) else {
            wordError(title: "Failed", message: "Challenge1")
            return
        }
        
        wordError(title: "Yay", message: "Score Boost")
        score += 1
        
        withAnimation{
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
                
                
                
    }
        
    
    var body: some View {
        NavigationView{
            VStack(spacing: 15){
                TextField("Enter String", text: $newWord)
                    .textInputAutocapitalization(.never)
                List{
                    ForEach(usedWords, id: \.self){ word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
                Text("Score: \(score)")
                    .font(.headline.weight(.bold))
            }
            .navigationTitle("\(rootWord)")
            .padding()
            .toolbar{
                Button("New Game"){
                    startGame()
                }
            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("OK"){ }
            } message: {
                Text(alertMessage)
            }
        }
        .onSubmit(addNewWord)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
