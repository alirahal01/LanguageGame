//
//  ContentView.swift
//  WordGame
//
//  Created by ali rahal on 02/04/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: WordsGameStore
    
    var body: some View {
        switch store.state.gameState {
        case .started:
            Text("Started")
        case .won:
            Text("Won")
        case .title:
            Text("Title")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(WordsGameStore(
                initial: WordsGameState(),
              reducer: wordsGameReducer
            ))
    }
}
