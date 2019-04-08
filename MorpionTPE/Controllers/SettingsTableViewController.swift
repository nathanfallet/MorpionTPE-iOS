//
//  SettingsTableViewController.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    var sections = [SettingsSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismiss(_:)))
        
        // Register cells
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "labelCell")
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: "switchCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "buttonCell")
        
        // Listen for color changes
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
        
        // Init colors
        isDarkMode() ? enableDarkMode() : disableDarkMode()
        
        // Load content
        sections += [
            SettingsSection(name: "Tic TAI PRO features", elements: [
                SettingsElementSwitch(id: "isDarkMode", text: "Enable dark mode", d: true)
            ]),
            SettingsSection(name: "Groupe MINASTE", elements: [
                SettingsElementButton(id: "moreApps", text: "More apps") { () in
                    UIApplication.shared.open(URL(string: "https://itunes.apple.com/us/developer/groupe-minaste/id1378426984")!)
                },
                SettingsElementButton(id: "donate", text: "Donate") { () in
                    UIApplication.shared.open(URL(string: "https://www.paypal.me/NathanFallet")!)
                }
            ])
        ]
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .darkModeEnabled, object: nil)
        NotificationCenter.default.removeObserver(self, name: .darkModeDisabled, object: nil)
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
        self.tableView.reloadData()
    }
    
    @objc func darkModeDisabled(_ notification: Foundation.Notification) {
        disableDarkMode()
        self.tableView.reloadData()
    }
    
    open func enableDarkMode() {
        self.view.backgroundColor = CustomColor.darkTableBackground
        self.tableView.backgroundColor = CustomColor.darkTableBackground
        self.tableView.separatorColor = CustomColor.darkSeparator
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.view.backgroundColor = CustomColor.darkBackground
        self.navigationController?.navigationBar.tintColor = CustomColor.darkActive
    }
    
    open func disableDarkMode() {
        self.view.backgroundColor = CustomColor.lightTableBackground
        self.tableView.backgroundColor = CustomColor.lightTableBackground
        self.tableView.separatorColor = CustomColor.lightSeparator
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.view.backgroundColor = CustomColor.lightBackground
        self.navigationController?.navigationBar.tintColor = CustomColor.lightActive
    }
    
    @objc func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].elements.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = sections[indexPath.section].elements[indexPath.row]
        
        if let e = element as? SettingsElementLabel {
            return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: e.text, darkMode: isDarkMode())
        } else if let e = element as? SettingsElementSwitch {
            let datas = UserDefaults.standard
            var enabled = e.d
            
            if(datas.value(forKey: e.id) != nil){
                enabled = datas.value(forKey: e.id) as! Bool
            }
            
            return (tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SwitchTableViewCell).with(id: e.id, text: e.text, preference: true, enabled: enabled, darkMode: isDarkMode())
        } else if let e = element as? SettingsElementButton {
            return (tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell).with(title: e.text, alignment: .left, handler: e.handler, darkMode: isDarkMode())
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

}
