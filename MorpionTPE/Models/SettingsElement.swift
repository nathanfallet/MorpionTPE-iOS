//
//  SettingsElement.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import Foundation

class SettingsElement {
    
    var id: String
    var text: String
    
    init(id: String, text: String) {
        self.id = id
        self.text = text
    }
    
}

class SettingsElementLabel: SettingsElement {
    
}

class SettingsElementSwitch: SettingsElement {
    
    var d: Bool
    
    init(id: String, text: String, d: Bool) {
        self.d = d
        super.init(id: id, text: text);
    }
    
}

class SettingsElementButton: SettingsElement {
    
    var handler: () -> Void
    
    init(id: String, text: String, completionHandler: @escaping () -> Void) {
        self.handler = completionHandler
        super.init(id: id, text: text)
    }
    
}
