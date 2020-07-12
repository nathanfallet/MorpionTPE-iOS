//
//  ThemedDonateTableViewCell.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 12/07/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit
import DonateViewController

class ThemedDonateTableViewCell: DonateCell {

    override func with(donation: Donation) -> DonateCell {
        // Apply current theme
        if isDarkMode() {
            backgroundColor = CustomColor.darkBackground
            textLabel?.textColor = CustomColor.darkText
            loading.style = .white
        } else {
            backgroundColor = CustomColor.lightBackground
            textLabel?.textColor = CustomColor.lightText
            loading.style = .gray
        }
        
        // Call super
        return super.with(donation: donation)
    }
    
    func isDarkMode() -> Bool {
        return UserDefaults.standard.bool(forKey: "isDarkMode")
    }

}
