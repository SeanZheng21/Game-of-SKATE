//
//  GameOfSkateVC.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/14/21.
//

import Foundation

class GameOfSkateVC: ObservableObject {
    private var gameModel: GameModel
    
    var letters: String {
        gameModel.letters
    }
    
    init(game: GameModel) {
        self.gameModel = game
    }
    
    init(letters: String, playerNames: [String]) {
        self.gameModel = GameModel(letters: letters, playerNames: playerNames)
    }
}
