//
//  UIViewControllerExtension.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 09/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func isDarkMode() -> Bool {
        let datas = UserDefaults.standard
        return datas.bool(forKey: "isDarkMode")
    }
    
    @objc func darkModeEnabled(_ notification: Foundation.Notification) {
        enableDarkMode()
    }
    
    @objc func darkModeDisabled(_ notification: Foundation.Notification) {
        disableDarkMode()
    }
    
    @objc func enableDarkMode() {
        self.view.backgroundColor = CustomColor.darkBackground
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    @objc func disableDarkMode() {
        self.view.backgroundColor = CustomColor.lightBackground
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
}
