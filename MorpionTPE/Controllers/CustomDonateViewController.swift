//
//  CustomDonateViewController.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 12/07/2020.
//  Copyright © 2020 Nathan FALLET. All rights reserved.
//

import UIKit
import DonateViewController

class CustomDonateViewController: DonateViewController, DonateViewControllerDelegate {
    
    override func viewDidLoad() {
        // Set strings
        title = "donate_title".localized()
        header = "donate_header".localized()
        footer = "donate_footer".localized()
        delegate = self
        
        // Add donations
        add(identifier: "me.nathanfallet.MorpionTPE.donation1")
        add(identifier: "me.nathanfallet.MorpionTPE.donation2")
        add(identifier: "me.nathanfallet.MorpionTPE.donation3")
        
        // Call super class
        super.viewDidLoad()
    }
    
    func donateViewController(_ controller: DonateViewController, didDonationSucceed donation: Donation) {
        let alert = UIAlertController(title: "donate_thanks".localized(), message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "back".localized(), style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func donateViewController(_ controller: DonateViewController, didDonationFailed donation: Donation) {
        print("Donation failed.")
    }

}
