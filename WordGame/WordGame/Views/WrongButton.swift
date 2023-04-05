//
//  wrongButton.swift
//  WordGame
//
//  Created by ali rahal on 05/04/2023.
//

import SwiftUI

struct WrongButton: View {
    @EnvironmentObject var store: WordsGameStore
    var body: some View {
        Button {
            self.store.dispatch(.wrongPressed)
        } label: {
            ZStack {
                Rectangle()
                    .fill(.red)
                    .frame(width: 150, height: 50)
                    .cornerRadius(50)
                Text("Wrong")
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

struct WrongButton_Previews: PreviewProvider {
    static var previews: some View {
        WrongButton()
            .environmentObject(WordsGameStore(
                initial: WordsGameState(),
                reducer: wordsGameReducer
            ))
    }
}
