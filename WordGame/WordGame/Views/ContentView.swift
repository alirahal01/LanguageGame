//
//  ContentView.swift
//  WordGame
//
//  Created by ali rahal on 02/04/2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: WordsGameStore
    @State var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            switch store.state.gameState {
            case .started:
                GameScreenView()
                    .tabItem({
                      VStack {
                          Image(systemName: "rectangle.dock")
                        Text("Test")
                      }
                    })
                    .tag(0)
            case .ended:
                GameEndedView()
                    .tabItem({
                      VStack {
                          Image(systemName: "rectangle.dock")
                        Text("Test")
                      }
                    })
                    .tag(0)
            }
            SettingsView()
                .tabItem({
                  VStack {
                      Image(systemName: "gear")
                      Text("Settings")
                  }
                })
                .tag(1)
        }
        .accentColor(.orange)
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
