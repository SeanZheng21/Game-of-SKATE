//
//  ContentView.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/3/21.
//

import SwiftUI

struct GameOfSkateView: View {
    @ObservedObject var game: GameOfSkateVC
    
    init(game: GameOfSkateVC) {
        self.game = game
    }
    
    var body: some View {
        Text("Hello, game of \(game.letters)!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameOfSkateView(game: GameOfSkateVC(letters: "skate",
                                            playerNames: ["Skatet 1", "Skater 2"]))
    }
}
