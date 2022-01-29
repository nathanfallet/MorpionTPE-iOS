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
        
        // Init colors
        if #available(iOS 13.0, *) {
            view.backgroundColor = .systemBackground
        } else {
            view.backgroundColor = .white
        }
        
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
        
        subname.text = "subname".localized()
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
        button1.setTitle("button1".localized(), for: .normal)
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
        button2.setTitle("button2".localized(), for: .normal)
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
        button3.setTitle("button3".localized(), for: .normal)
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
        
        settings.setTitle("settings".localized(), for: .normal)
        settings.setTitleColor(.white, for: .normal)
        settings.backgroundColor = CustomColor.lightActive
        settings.addTarget(self, action: #selector(openSettings(_:)), for: .touchUpInside)
        
        // Setup the bottom text
        bottom.translatesAutoresizingMaskIntoConstraints = false
        
        bottom.topAnchor.constraint(equalTo: settings.bottomAnchor, constant: 40).isActive = true
        bottom.centerXAnchor.constraint(equalTo: menu.centerXAnchor).isActive = true
        bottom.bottomAnchor.constraint(equalTo: menu.bottomAnchor).isActive = true
        bottom.widthAnchor.constraint(equalToConstant: 300).isActive = true
        
        bottom.text = "bottom".localized()
        bottom.numberOfLines = 0
        bottom.textAlignment = .center
    }
    
    @objc func startGame(_ sender: UIButton) {
        let game: Game
        
        if sender.tag == 0 {
            game = Game(player1: Human(sign: .X), player2: Human(sign: .O))
        } else if sender.tag == 1 {
            let players = [Computer(sign: .X), Human(sign: .O)].shuffled()
            game = Game(player1: players[0], player2: players[1])
        } else {
            game = Game(player1: Computer(sign: .X), player2: Computer(sign: .O))
        }
        
        let gameVC = GameViewController(game: game)
        gameVC.modalPresentationStyle = .fullScreen
        
        present(gameVC, animated: true, completion: nil)
    }
    
    @objc func openSettings(_ sender: UIButton) {
        let settingsVC = UINavigationController(rootViewController: SettingsTableViewController(style: .grouped))
        settingsVC.modalPresentationStyle = .fullScreen
        
        present(settingsVC, animated: true, completion: nil)
    }

}
