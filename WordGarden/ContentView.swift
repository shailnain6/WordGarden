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
    @State private var wordToGuess = ["SWIFT", "DOG", "CAT"]
    @State private var gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
    @State private var currentWord = 0
    @State private var guessedLetter = ""
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @FocusState private var textFieldIsFocused: Bool
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
            
            Text("_ _ _ _ _")
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
                    
                    Button("Guess a Letter:") {
                        textFieldIsFocused = false
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
    }
}

#Preview {
    ContentView()
}
