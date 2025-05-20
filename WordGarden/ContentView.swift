//
//  ContentView.swift
//  WordGarden
//
//  Created by Shailendra Nain on 5/13/25.
//

import SwiftUI

struct ContentView: View {
    private static let maximumGuesses = 8
    
    @State private var wordGuessed = 0
    @State private var wordMissed = 0
    @State private var gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
    @State private var currentWordIndex = 0
    @State private var wordToGuess = ""
    @State private var revealedWord = ""
    @State private var guessedLetter = ""
    @State private var letterGuessed = ""
    @State private var guessesRemaining = maximumGuesses
    @State private var imageName = "flower8"
    @State private var playAgainHidden = true
    @State private var playAgainButtonLabel = "Another Word?"
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
                .frame(height: 80)
                .minimumScaleFactor(0.5)
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
                        updateGamePlay()
                    }
                    .buttonStyle(.bordered)
                    .tint(.green)
                    .fontWeight(.bold)
                    .disabled(guessedLetter.isEmpty)
                    
                }
            } else {
                Button(playAgainButtonLabel) {
                    if currentWordIndex == wordsToGuess.count {
                        currentWordIndex = 0
                        wordGuessed = 0
                        wordMissed = 0
                        playAgainButtonLabel = "Another Word?"
                    }
                  wordToGuess = wordsToGuess[currentWordIndex]
                    revealedWord = "_" + String(repeating: " _", count: wordToGuess.count - 1)
                    letterGuessed = ""
                    guessesRemaining = Self.maximumGuesses
                    imageName = "flower\(guessesRemaining)"
                    gameStatusMessage = "How Many Guesses to Uncover the Hidden Word?"
                    playAgainHidden = true
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
    }
    
    func updateGamePlay() {
        if !wordToGuess.contains(guessedLetter) {
            guessesRemaining -= 1
            imageName = "flower\(guessesRemaining)"
        }
        if !revealedWord.contains("_") {
            gameStatusMessage = "You Guessed It! It Took you \(letterGuessed.count) Guess the word."
            wordGuessed += 1
            currentWordIndex += 1
            playAgainHidden = false
        } else if guessesRemaining == 0 {
            gameStatusMessage = "So Sorry you are all out of Guesses"
            wordGuessed += 1
            currentWordIndex += 1
            playAgainHidden = false
        } else {
            gameStatusMessage = "You've Made \(letterGuessed.count) Guess\(letterGuessed.count == 1 ? "" : "es")"
        }
        if currentWordIndex == wordsToGuess.count {
            playAgainButtonLabel = "Restart Game?"
            gameStatusMessage = "You have guessed all the remaining words!"
        }
        guessedLetter = ""
    }
}

#Preview {
    ContentView()
}
