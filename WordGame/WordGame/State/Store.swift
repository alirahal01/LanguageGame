//
//  Store.swift
//  WordGame
//
//  Created by ali rahal on 03/04/2023.
//

import Foundation
import Combine

typealias WordsGameStore = Store<WordsGameState, WordsGameActions>

class Store<State, Action>: ObservableObject {
    
    @Published private(set) var state: State
    private let reducer: Reducer<State, Action>
    private let middlewares: [Middleware<State, Action>]
    private var subscriptions: Set<AnyCancellable> = []

    private let queue = DispatchQueue(label: "Com.Test.WordsGame.Store", qos: .userInitiated)
    init(
        initial: State,
        reducer: @escaping Reducer<State,Action>,
        middlewares: [Middleware<State, Action>] = []
    ) {
        self.state = initial
        self.reducer = reducer
        self.middlewares = middlewares
    }
    
    func dispatch(_ action: Action) {
        queue.sync {
            self.dispatch(self.state, action)
        }
    }
    
    private func dispatch(_ currentState: State, _ action: Action) {
        let newState = reducer(currentState, action)
        state = newState
        middlewares.forEach { middleware in
          // 2
          let publisher = middleware(newState, action)
          publisher
            // 3
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: dispatch)
            .store(in: &subscriptions)
        }
    }
}
