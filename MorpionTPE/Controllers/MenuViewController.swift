//
//  MenuViewController.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    let menu = UIView()
    let name = UILabel()
    let subname = UILabel()
    let button1 = UIButton()
    let button2 = UIButton()
    let button3 = UIButton()
    let settings = UIButton()
    let bottom = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Listen for color changes
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
        
        // Init colors
        isDarkMode() ? enableDarkMode() : disableDarkMode()
        
        // Add elements to view
        view.addSubview(menu)
        view.addSubview(name)
        view.addSubview(subname)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(settings)
        view.addSubview(bottom)

        // Setup menu
        menu.translatesAutoresizingMaskIntoConstraints = false
        menu.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        menu.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor).isActive = true
        
        // Setup name
        name.translatesAutoresizingMaskIntoConstraints = false
        
        name.topAnchor.constraint(equalTo: menu.topAnchor).isActive = true
        name.centerXAnchor.constraint(equalTo: menu.centerXAnchor).isActive = true
        name.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        name.text = "Tic TAI Toe"
        name.font = UIFont.boldSystemFont(ofSize: 48)
        name.adjustsFontSizeToFitWidth = true
        name.textAlignment = .center
        
        // Setup subname
        subname.translatesAutoresizingMaskIntoConstraints = false
        
        subname.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20).isActive = true
        subname.centerXAnchor.constraint(equalTo: menu.centerXAnchor).isActive = true
        subname.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        subname.text = "A tic tac toe, with an AI and a PRO feature"
        subname.numberOfLines = 0
        subname.textAlignment = .center
        
        // Setup 1st button
        button1.translatesAutoresizingMaskIntoConstraints = false
        
        button1.topAnchor.constraint(equalTo: subname.bottomAnchor, constant: 40).isActive = true
        button1.centerXAnchor.constraint(equalTo: menu.centerXAnchor).isActive = true
        button1.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button1.layer.cornerRadius = 4
        button1.clipsToBounds = true
        
        button1.tag = 0
        button1.setTitle("Player VS Player", for: .normal)
        button1.setTitleColor(.white, for: .normal)
        button1.backgroundColor = CustomColor.darkActive
        button1.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        
        // Setup 2nd button
        button2.translatesAutoresizingMaskIntoConstraints = false
        
        button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 20).isActive = true
        button2.centerXAnchor.constraint(equalTo: menu.centerXAnchor).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button2.layer.cornerRadius = 4
        button2.clipsToBounds = true
        
        button2.tag = 1
        button2.setTitle("Player VS Computer", for: .normal)
        button2.setTitleColor(.white, for: .normal)
        button2.backgroundColor = CustomColor.darkActive
        button2.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        
        // Setup 3rd button
        button3.translatesAutoresizingMaskIntoConstraints = false
        
        button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 20).isActive = true
        button3.centerXAnchor.constraint(equalTo: menu.centerXAnchor).isActive = true
        button3.widthAnchor.constraint(equalToConstant: 300).isActive = true
        button3.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        button3.layer.cornerRadius = 4
        button3.clipsToBounds = true
        
        button3.tag = 2
        button3.setTitle("Computer VS Computer", for: .normal)
        button3.setTitleColor(.white, for: .normal)
        button3.backgroundColor = CustomColor.darkActive
        button3.addTarget(self, action: #selector(startGame(_:)), for: .touchUpInside)
        
        // Setup settings button
        settings.translatesAutoresizingMaskIntoConstraints = false
        
        settings.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 20).isActive = true
        settings.centerXAnchor.constraint(equalTo: menu.centerXAnchor).isActive = true
        settings.widthAnchor.constraint(equalToConstant: 300).isActive = true
        settings.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        settings.layer.cornerRadius = 4
        settings.clipsToBounds = true
        
        settings.setTitle("Settings", for: .normal)
        settings.setTitleColor(.white, for: .normal)
        settings.backgroundColor = CustomColor.lightActive
        settings.addTarget(self, action: #selector(openSettings(_:)), for: .touchUpInside)
        
        // Setup the bottom text
        bottom.translatesAutoresizingMaskIntoConstraints = false
        
        bottom.topAnchor.constraint(equalTo: settings.bottomAnchor, constant: 40).isActive = true
        bottom.centerXAnchor.constraint(equalTo: menu.centerXAnchor).isActive = true
        bottom.bottomAnchor.constraint(equalTo: menu.bottomAnchor).isActive = true
        bottom.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        bottom.text = "App made by Nathan Fallet\n© Groupe MINASTE"
        bottom.numberOfLines = 0
        bottom.textAlignment = .center
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
    }
    
    @objc func startGame(_ sender: UIButton) {
        let game: Game
        
        if sender.tag == 0 {
            game = Game(player1: Human(sign: .X), player2: Human(sign: .O))
        } else if sender.tag == 1 {
            game = Game(player1: Computer(sign: .X), player2: Human(sign: .O))
        } else {
            game = Game(player1: Computer(sign: .X), player2: Computer(sign: .O))
        }
        
        let gameVC = GameViewController(game: game)
        
        present(gameVC, animated: true, completion: nil)
    }
    
    @objc func openSettings(_ sender: UIButton) {
        let settingsVC = UINavigationController(rootViewController: SettingsTableViewController(style: .grouped))
        
        present(settingsVC, animated: true, completion: nil)
    }
    
    func isDarkMode() -> Bool {
        let datas = UserDefaults.standard
        
        if(datas.value(forKey: "isDarkMode") != nil){
            return datas.value(forKey: "isDarkMode") as! Bool
        }
        return false
    }
    
    @objc func darkModeEnabled(_ notification: Foundation.Notification) {
        enableDarkMode()
    }
    
    @objc func darkModeDisabled(_ notification: Foundation.Notification) {
        disableDarkMode()
    }
    
    open func enableDarkMode() {
        self.view.backgroundColor = CustomColor.darkBackground
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.view.backgroundColor = CustomColor.darkBackground
        self.navigationController?.navigationBar.tintColor = CustomColor.darkActive
        self.name.textColor = CustomColor.darkText
        self.bottom.textColor = CustomColor.darkText
    }
    
    open func disableDarkMode() {
        self.view.backgroundColor = CustomColor.lightBackground
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.view.backgroundColor = CustomColor.lightBackground
        self.navigationController?.navigationBar.tintColor = CustomColor.lightActive
        self.name.textColor = CustomColor.lightText
        self.bottom.textColor = CustomColor.lightText
    }

}
