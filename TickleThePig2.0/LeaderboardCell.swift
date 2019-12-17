//
//  LeaderboardCell.swift
//  TickleThePig2.0
//
//  Created by Brian Broeking on 10/7/19.
//  Copyright © 2019 Brian Broeking. All rights reserved.
//

import UIKit

class LeaderboardCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var count: UILabel!
    

    func setCell(cell: cellData){
        name.text = cell.uid
        count.text = String(cell.count)
    }
}
