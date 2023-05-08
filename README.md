# Spanish Learning Game 

## Motivation:
I want to make a project which exercies different domain know-how:
- SwiftUI 
- Animation
- Basic Redux-Unidirectional architecture implementation
- This project is considered a prerequisite  for the next project that will be done using the swift composable architecture (TCA)

## App Demo

https://user-images.githubusercontent.com/26170395/236908145-c368adfd-ad6f-4a09-b36a-e0d826d4f81d.mov


## Features
The app has three screens
- Game Screen View
- Game Ended View
- Settings

This screen has multiple functionalites
- User can click on correct or wrong answer and the score will be updated 
- If the round time has passed and user didnt chose any answer , no answers counter will be updated
- User can update round count and nubmer of questions from the settings

## Architecture

The app uses a Unidirectional Data Flow Architecture (Redux-like architecture).

![middleware](https://user-images.githubusercontent.com/26170395/236257422-ecfa75b7-dd44-421a-a995-338d4f7378dc.png)

- A global state is used to ensure consistency across all Views being kept in Stores. 
- Views can dispatch Actions which are interpreted into state changes by a reducer.
- Reducers purpose is to return a new state based on a given action
- Middleware is a component that sits between the action creator and the reducer. It intercepts actions that are dispatched by the views before they reach the reducer and it can perform additional processing on the action such as logging, modifying or removing.

## Device Support

The only supported orientation is portrait mode.


## References And Inspirations
- https://github.com/kodecocodes/sui-materials 
- https://www.kodeco.com/22096649-getting-a-redux-vibe-into-swiftui
- https://www.youtube.com/watch?v=NkssjWSmzIg

