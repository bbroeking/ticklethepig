//
//  SettingsCell.swift
//  SettingsTemplate
//
//  Created by Stephen Dowless on 2/10/19.
//  Copyright © 2019 Stephan Dowless. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    private let decreaseButton : UIButton = {
    let btn = UIButton(type: .custom)
    let btnImage = UIImage(named: "Cooper_pig")
    btn.setImage(btnImage , for: UIControl.State.normal)
    btn.imageView?.contentMode = .scaleAspectFill
    return btn
    }()
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(decreaseButton)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
