//
//  WordGameApp.swift
//  WordGame
//
//  Created by ali rahal on 02/04/2023.
//

import SwiftUI

@main
struct WordGameApp: App {
    @AppStorage("appearance") var appearance: Appearance = .automatic
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WordsGameStore(
                    initial: WordsGameState(),
                    reducer: wordsGameReducer,
                    middlewares: [gameLogic]
                ))
                .preferredColorScheme(appearance.getColorScheme())
        }
    }
}
