//
//  SettingsSection.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import Foundation

class SettingsSection {
    
    var name: String
    var elements: [SettingsElement]
    
    init(name: String, elements: [SettingsElement]) {
        self.name = name
        self.elements = elements
    }
    
}
