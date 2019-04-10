//
//  Computer.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import Foundation

class Computer: Player {
    
    // Override player play function
    override func play(game: Game, completion: @escaping (Int, Int) -> ()) {
        let deadline: DispatchTime = .now() + 1
        let (x, y) = bestMove(game: game, table: game.table, sign: sign).0
        DispatchQueue.global(qos: .background).asyncAfter(deadline: deadline) {
            completion(x, y)
        }
    }
    
    // Select the best possibility of game
    func bestMove(game: Game, table: [[Sign]], sign: Sign) -> ((Int, Int), Int) {
        // Get the sign of ennemy
        let other = sign == .O ? Sign.X : Sign.O
        
        // Create an array for moves
        var moves = [((Int, Int), Int)]()
        
        // Iterate the table to find all moves
        for x in 0 ..< 3 {
            for y in 0 ..< 3 {
                // If the cell is free
                if table[x][y] == .empty {
                    // We copy the table in which we will test
                    var copy = table.map {
                        $0.map {
                            $0 == Sign.empty ? Sign.empty : $0 == Sign.X ? Sign.X : Sign.O
                        }
                    }
                    copy[x][y] = sign
                    
                    // And we get the result
                    let win = game.win(table: copy)
                    let score: Int
                    
                    // If the table is full
                    if win == .empty && game.full(table: copy) {
                        score = 0
                    }
                    // If it allows to win, score is 1
                    else if win == sign {
                        score = 1
                    }
                    // Else it is the opposite of the oponent best score (0 or -1)
                    else {
                        score = 0 - bestMove(game: game, table: copy, sign: other).1
                    }
                    
                    let result = ((x, y), score)
                    
                    // if the score is 1 we return the result
                    if score == 1 {
                        return result
                    }
                    
                    // Else we add the result in the array and we continue
                    moves.append(result)
                }
            }
        }
        
        // We suffle the moves
        moves.shuffle()
        moves.sort {
            return $0.1 > $1.1
        }
        
        // Return the best move
        return moves[0]
    }
    
}
