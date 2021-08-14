//
//  GameOfSkateApp.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/3/21.
//

import SwiftUI

@main
struct GameOfSkateApp: App {
    var body: some Scene {
        WindowGroup {
            GameOfSkateView(game: GameOfSkateVC(letters: "skate",
                                                playerNames: ["Skatet 1", "Skater 2", "Skater 3"]))
        }
    }
}
