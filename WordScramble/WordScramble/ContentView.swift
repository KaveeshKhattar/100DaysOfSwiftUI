//
//  ContentView.swift
//  WordScramble
//
//  Created by Kaveesh Khattar on 19/10/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var listOfTypedWords = [String]()
    @State private var wordFromDict = ""
    @State private var wordFromUser = ""
    @State private var answer = ""
    @State private var userScore = 0.0
    
    // adding user entered word to list to display on screen
    func addNewWord(){
        let enteredWord = wordFromUser.lowercased().trimmingCharacters(in: .whitespaces)
        
        guard enteredWord.count > 0 else {
            return
        }
        
        guard (enteredWord.count >= 3) else {
            wordError(title: "Word is less than 3 characters", message: "Improve vocabulary")
            return
        }
        
        guard isOriginal(word: enteredWord) else{
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: enteredWord) else{
            wordError(title: "Word not recognised", message: "You can't just make them up, you know")
            return
        }
        guard isReal(word: enteredWord) else{
            wordError(title: "Word not possible", message: "That isn't a real word")
            return
        }
        
        listOfTypedWords.insert(enteredWord, at: 0)
        userScore = userScore + 1 + Double(wordFromUser.count)/10
        wordFromUser = ""
        
    }
    
    // for title of game
    func startGame(){
        // 1. Find the URL for start.txt in bundle
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            // 2. Load start.txt into a string
            if let startWords = try? String(contentsOf: startWordsURL){
                // 3. Split the string up into an array of strings, splitting on line breaks
                let allWords = startWords.components(separatedBy: "\n")
                
                // 4. Pick one random word
                wordFromDict = allWords.randomElement() ?? "kaveesh"
                listOfTypedWords = []
                userScore = 0
                // Everything has worked
                return
            }
        }
        // there was a problem
        fatalError("Could not load start.txt from bundle.")
    }
    
    // is the word original
    func isOriginal(word: String) -> Bool {
        !listOfTypedWords.contains(word)
    }
    
    // to make sure the user can't enter invalid words, is the word possible
    func isPossible(word: String) -> Bool{
        var tempWord = wordFromDict
        
        for letter in word{
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else{
                return false
            }
        }
        return true
    }
    
    
    // is the word real
    func isReal(word: String) -> Bool{
                
        if(word == wordFromDict){
            return false
        }
        
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
        
    }
    
    
    // display error messages easily
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
     
    var body: some View {
        NavigationView{
            Form{
                
                TextField("Enter your word", text: $wordFromUser, onCommit: addNewWord)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.none)
                
                List(listOfTypedWords, id: \.self){ word in
                    HStack{
                        Image(systemName: "\(word.count).circle")
                        Text(word)
                    }
                }
                
                Text("User score: \(userScore, specifier: "%g")")
                
            }
            .navigationBarTitle("\(wordFromDict)")
            .onAppear(perform: startGame)
            .alert(isPresented: $showingError){
                Alert(title: Text(errorTitle), message: Text(errorMessage), dismissButton: .default(Text("OK")))
            }
            .navigationBarItems(leading:
                                    Button("Start game"){
                                        startGame()
                                    })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
