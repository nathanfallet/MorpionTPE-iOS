//
//  NotificationNameExtension.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import Foundation

extension Notification.Name {
    
    // Game
    static let boardChanged = Notification.Name("me.nathanfallet.MorpionTPE.boardChanged")
    
    // PRO features
    static let hardcoreUnlocked = Notification.Name("me.nathanfallet.MorpionTPE.hardcoreUnlocked")
    
}
