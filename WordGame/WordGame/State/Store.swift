//
//  Store.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation

typealias WordsGameStore = Store<WordsGameState, WordsGameAction>

class Store<State, Action>: ObservableObject {
  
  @Published private(set) var state: State
  private let reducer: Reducer<State, Action>
    
  private let queue = DispatchQueue(label: "Com.Test.WordsGame.Store", qos: .userInitiated)
  init(
    initial: State,
    reducer: @escaping Reducer<State,Action>
  ) {
    self.state = initial
    self.reducer = reducer
  }
  
  func dispatch(_ action: Action) {
    queue.sync {
      self.dispatch(self.state, action)
    }
  }
  
  private func dispatch(_ currentState: State, _ action: Action) {
    let newState = reducer(currentState, action)
    state = newState
  }
}
