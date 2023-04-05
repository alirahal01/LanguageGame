//
//  CorrectButton.swift
//  WordGame
//
//  Created by ali rahal on 05/04/2023.
//

import SwiftUI

struct CorrectButton: View {
    @EnvironmentObject var store: WordsGameStore
    var body: some View {
        Button {
            self.store.dispatch(.correctPressed)
        } label: {
            ZStack {
                Rectangle()
                    .fill(.green)
                    .frame(width: 150, height: 50)
                    .cornerRadius(50)
                Text("Correct")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(10)
                    .minimumScaleFactor(0.05)

            }
            .shadow(radius: 8)
            .frame(width: 150, height: 50)
        }
    }
}

struct CorrectButton_Previews: PreviewProvider {
    static var previews: some View {
        CorrectButton()
            .environmentObject(WordsGameStore(
                initial: WordsGameState(),
                reducer: wordsGameReducer
            ))
    }
}
