//
//  Player.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import Foundation

class Player {
    
    var sign: Sign
    
    init(sign: Sign) {
        self.sign = sign
    }
    
    func play(game: Game, completion: @escaping (Int, Int) -> ()) {
        completion(0, 0)
    }
    
}
