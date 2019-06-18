//
//  SwitchTableViewCell.swift
//  Alarm
//
//  Created by Trevor Walker on 6/17/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import UIKit
protocol SwitchTableViewDelegate: class {
    func switchChanged(cell: SwitchTableViewCell)
}
class SwitchTableViewCell: UITableViewCell {
//Mark: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var alarmSwitch: UISwitch!
    func update(alarm: Alarm){
        nameLabel.text = alarm.name
        timeLabel.text = alarm.fireTime
        alarmSwitch.isOn = alarm.isEnabled
    }
//Mark: - Defines Delegate
    weak var cellDelegate: SwitchTableViewDelegate?
    
    @IBAction func switchPressed(_ sender: Any) {
        cellDelegate?.switchChanged(cell: self)
    }
    
}
