//
//  Middleware.swift
//  WordGame
//
//  Created by ali rahal on 05/04/2023.
//

import Foundation
import Combine

typealias Middleware<State, Action> =
  (State, Action) -> AnyPublisher<Action, Never>
