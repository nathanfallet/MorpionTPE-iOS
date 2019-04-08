//
//  Human.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import Foundation

class Human: Player {
    
    var completion: ((Int, Int) -> ())?
    
    override func play(game: Game, completion: @escaping (Int, Int) -> ()) {
        self.completion = completion
    }
    
}
