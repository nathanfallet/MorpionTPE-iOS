//
//  ButtonTableViewCell.swift
//  MorpionTPE
//
//  Created by Nathan FALLET on 08/04/2019.
//  Copyright © 2019 Nathan FALLET. All rights reserved.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {

    var button: UIButton = UIButton()
    var handler: () -> () = { () in }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        contentView.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor).isActive = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(CustomColor.lightActive, for: .normal)
        button.addTarget(self, action: #selector(onClick(_:)), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func with(title: String, alignment: UIControl.ContentHorizontalAlignment = .center, handler: @escaping () -> ()) -> ButtonTableViewCell {
        self.handler = handler
        button.setTitle(title, for: .normal)
        button.contentHorizontalAlignment = alignment
        
        return self
    }
    
    @objc func onClick(_ sender: Any) {
        handler()
    }

}
