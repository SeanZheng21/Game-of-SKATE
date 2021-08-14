//
//  GameModel.swift
//  Game of SKATE
//
//  Created by Carlistle ZHENG on 8/14/21.
//

import Foundation

struct GameModel {
    private(set) var letters: String
    private var players: [Player]
    
    init(letters: String="SKATE", playerNames: [String]=["Skater 1", "Skater 2"]) {
        self.letters = letters
        self.players = []
        for playerName in playerNames {
            self.players.append(Player(name: playerName))
        }
    }
    
    
    struct Player {
        private(set) var name: String
        
        init(name: String) {
            self.name = name
        }
    }
}
