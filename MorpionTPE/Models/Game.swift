//
//  Game.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import Foundation
import StoreKit

class Game {
    
    // Game vars
    var table: [[Sign]]
    var player1: Player
    var player2: Player
    var current: Sign
    
    // Init the game
    init(player1: Player, player2: Player) {
        self.table = [[.empty, .empty, .empty], [.empty, .empty, .empty], [.empty, .empty, .empty]]
        self.player1 = player1
        self.player2 = player2
        self.current = player1.sign
    }
    
    // Gameplay
    func nextMove() {
        let win = self.win(table: table)
        
        // Check that it's not the end of the game
        if !full(table: table) && win == .empty {
            // Iterate the players
            for player in [player1, player2] {
                if player.sign == current {
                    // Here the player plays
                    player.play(game: self) { (x, y) in
                        // Set the move
                        if self.play(x: x, y: y, sign: player.sign) {
                            self.current = self.current == .X ? .O : .X
                        }
                        
                        // Update UI
                        NotificationCenter.default.post(name: .boardChanged, object: nil)
                        
                        // And go to next move
                        self.nextMove()
                    }
                    
                    // Stop here
                    return
                }
            }
        }
        
        // The game ended
        current = .empty
        NotificationCenter.default.post(name: .boardChanged, object: nil)
        
        // Update game count
        let datas = UserDefaults.standard
        let numberOfGamesPlayed = datas.integer(forKey: "numberOfGamesPlayed") + 1
        datas.set(numberOfGamesPlayed, forKey: "numberOfGamesPlayed")
        datas.synchronize()
        
        // Check for new PRO features
        let hardcoreUnlocked = datas.bool(forKey: "hardcoreUnlocked")
        
        // Check for hardcore
        if !hardcoreUnlocked && ((player1 as? Human != nil && player2 as? Computer != nil && win == player1.sign) || (player1 as? Computer != nil && player2 as? Human != nil && win == player2.sign)) {
            // Save that the feature is unlocked
            datas.set(true, forKey: "hardcoreUnlocked")
            datas.synchronize()
            
            // And show alert
            NotificationCenter.default.post(name: .hardcoreUnlocked, object: nil)
        }
        
        // Ask the user to review the app
        if numberOfGamesPlayed == 10 || numberOfGamesPlayed == 50 || numberOfGamesPlayed % 100 == 0 {
            SKStoreReviewController.requestReview()
        }
    }
    
    // Make a player plays in the board
    func play(x: Int, y: Int, sign: Sign) -> Bool {
        if x >= 0 && x < 3 && y >= 0 && y < 3 && table[x][y] == .empty {
            table[x][y] = sign
            return true
        }
        
        return false
    }
    
    // Check is there is a winner
    func win(table: [[Sign]]) -> Sign {
        for i in 0 ..< 3 {
            // Check if a line has a winner
            let line = self.line(table: table, y: i)
            if line != .empty {
                return line
            }
            
            // Check if a row has a winner
            let row = self.row(table: table, x: i)
            if row != .empty {
                return row
            }
        }
        
        for i in 0 ..< 2 {
            // Check is a dia has a winner
            let dia = self.dia(table: table, d: i)
            if dia != .empty {
                return dia
            }
        }
        
        return .empty
    }
    
    // Check if a line is full
    func line(table: [[Sign]], y: Int) -> Sign {
        let sign = table[0][y]
        var changed = false
        
        for x in 0 ..< 3 {
            if table[x][y] != sign {
                changed = true
            }
        }
        
        if changed {
            return .empty
        }
        
        return sign
    }
    
    // Check if a row is full
    func row(table: [[Sign]], x: Int) -> Sign {
        let sign = table[x][0]
        var changed = false
        
        for y in 0 ..< 3 {
            if table[x][y] != sign {
                changed = true
            }
        }
        
        if changed {
            return .empty
        }
        
        return sign
    }
    
    // Check if a dia is full
    func dia(table: [[Sign]], d: Int) -> Sign {
        var i = d == 0 ? 0 : 2
        let sign = table[i][0]
        var changed = false
        
        for x in 0 ..< 3 {
            i = d == 0 ? x : 2 - x
            if table[i][x] != sign {
                changed = true
            }
        }
        
        if changed {
            return .empty
        }
        
        return sign
    }
    
    // Check if the board is full
    func full(table: [[Sign]]) -> Bool {
        for x in 0 ..< 3 {
            for y in 0 ..< 3 {
                if table[x][y] == .empty {
                    return false
                }
            }
        }
        return true
    }
    
}
