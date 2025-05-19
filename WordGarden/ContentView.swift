//
//  ContentView.swift
//  WordGarden
//
//  Created by Shailendra Nain on 5/13/25.
//

import SwiftUI

struct ContentView: View {
    @State private var wordGuessed = 0
    @State private var wordMissed = 0
    @State private var gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
    @State private var currentWordIndex = 0
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var guessedLetter = ""
    @State private var letterGuessed = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @FocusState private var textFieldIsFocused: Bool
    private let wordsToGuess = ["TOM", "DOG", "CAT"]
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Word Guessed: \(wordGuessed)")
                    Text("Word Missed: \(wordMissed)")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Word to Guess: \(wordToGuess.count - (wordGuessed + wordMissed))")
                    Text("Word in Game: \(wordToGuess.count)")
                }
            }
            .padding()
            Spacer()
            Text(gameStatusMessage)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.center)
                .padding()
            
            Text(revealedWord)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            if playAgainHidden {
                HStack {
                    TextField("", text: $guessedLetter)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 30)
                        .overlay {
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 2)
                    }
                        .keyboardType(.asciiCapable)
                        .focused($textFieldIsFocused)
                        .submitLabel(.done)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.characters)
                        .onChange(of: guessedLetter) {
                            guessedLetter = guessedLetter.trimmingCharacters(in: .letters.inverted)
                            guard let lastChar = guessedLetter.last else {
                                return
                            }
                            guessedLetter = String(lastChar).uppercased()
                            
                        }
                        .onSubmit {
                            guard guessedLetter != "" else {
                                return
                            }
                            guessALetter()
                        }
                    
                    Button("Guess a Letter:") {
                        guessALetter()
                    }
                    .buttonStyle(.bordered)
                    .tint(.green)
                    .fontWeight(.bold)
                    .disabled(guessedLetter.isEmpty)
                    
                }
            } else {
                Button("Another Word?") {
                  
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .fontWeight(.bold)
                
            }
            Spacer()
            Image(imageName)
                .resizable()
                .scaledToFit()
        }
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            wordToGuess = wordsToGuess[currentWordIndex]
            revealedWord = "_" + String(repeating: " _", count: wordToGuess.count - 1)
        }
    }
    func guessALetter() {
        textFieldIsFocused = false
        letterGuessed = letterGuessed + guessedLetter
        revealedWord = wordToGuess.map { letter in
            letterGuessed.contains(letter) ? "\(letter)" : "_"
        }.joined(separator: " ")
        guessedLetter = ""
    }
}

#Preview {
    ContentView()
}
