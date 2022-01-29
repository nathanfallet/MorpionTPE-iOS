//
//  SettingsTableViewController.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import UIKit
import DonateViewController
import MyAppsiOS

class SettingsTableViewController: UITableViewController {
    
    var sections = [SettingsSection]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Navigation
        navigationItem.title = "settings".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismiss(_:)))
        
        // Register cells
        tableView.register(LabelTableViewCell.self, forCellReuseIdentifier: "labelCell")
        tableView.register(SwitchTableViewCell.self, forCellReuseIdentifier: "switchCell")
        tableView.register(ButtonTableViewCell.self, forCellReuseIdentifier: "buttonCell")
        tableView.register(MyAppTableViewCell.self, forCellReuseIdentifier: "myAppCell")
        
        // Check if PRO features are available
        let datas = UserDefaults.standard
        let hardcoreUnlocked = datas.bool(forKey: "hardcoreUnlocked")
        
        // Create PRO section and add elements
        let pro = SettingsSection(name: "pro".localized(), elements: [])
        if hardcoreUnlocked {
            pro.elements += [SettingsElementSwitch(id: "isHardcore", text: "isHardcore".localized(), d: false)]
        }
        if pro.elements.count == 0 {
            pro.elements += [SettingsElementLabel(id: "no_pro", text: "no_pro".localized())]
        }
        
        // Load content
        sections += [
            pro,
            SettingsSection(name: "about".localized(), elements: [
                SettingsElementButton(id: "video", text: "video".localized()) { () in
                    UIApplication.shared.open(URL(string: "https://www.youtube.com/watch?v=mRbCu4uizYc")!)
                },
                SettingsElementButton(id: "instagram", text: "instagram".localized()) { () in
                    UIApplication.shared.open(URL(string: "https://www.instagram.com/nathanfallet/")!)
                }
            ]),
            SettingsSection(name: "Groupe MINASTE", elements: [
                SettingsElementButton(id: "donate", text: "donate_title".localized()) { () in
                    self.navigationController?.pushViewController(CustomDonateViewController(), animated: true)
                }
            ])
        ]
    }
    
    @objc func dismiss(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count + 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == sections.count ? MyApp.values.count : sections[section].elements.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == sections.count ? MyAppHeaderText.localizedString : sections[section].name
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == sections.count {
            return (tableView.dequeueReusableCell(withIdentifier: "myAppCell", for: indexPath) as! MyAppTableViewCell).with(app: MyApp.values[indexPath.row])
        }
        
        let element = sections[indexPath.section].elements[indexPath.row]
        
        if let e = element as? SettingsElementLabel {
            return (tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! LabelTableViewCell).with(text: e.text)
        } else if let e = element as? SettingsElementSwitch {
            let datas = UserDefaults.standard
            var enabled = e.d
            
            if datas.value(forKey: e.id) != nil {
                enabled = datas.bool(forKey: e.id)
            }
            
            return (tableView.dequeueReusableCell(withIdentifier: "switchCell", for: indexPath) as! SwitchTableViewCell).with(id: e.id, text: e.text, preference: true, enabled: enabled)
        } else if let e = element as? SettingsElementButton {
            return (tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as! ButtonTableViewCell).with(title: e.text, alignment: .left, handler: e.handler)
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == sections.count {
            (tableView.cellForRow(at: indexPath) as? MyAppTableViewCell)?.openURL()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == sections.count ? 68 : 44
    }

}
