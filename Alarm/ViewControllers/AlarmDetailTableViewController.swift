//
//  AlarmDetailTableViewController.swift
//  Alarm
//
//  Created by Trevor Walker on 6/17/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var enableDisable: UIButton!
    
    var landingPad: Alarm?
    var localIsEnabled: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.delegate = self
        localIsEnabled = true
        enableDisable.layer.cornerRadius = enableDisable.frame.height / 2.0
        guard let isEnabled = landingPad?.isEnabled, let name = landingPad?.name, let time = landingPad?.fireDate else {return}
        localIsEnabled = !isEnabled
        updateButton()
        nameLabel.text = name
        timePicker.date = time
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        localIsEnabled = !localIsEnabled
        updateButton()
        
    }
    @IBAction func save(_ sender: Any) {
        guard let name = nameLabel.text else {return}
        if let alarm = landingPad{
            AlarmController.shared.update(alarm: alarm, fireDate: timePicker.date, name: name, isEnabled: !localIsEnabled)
        } else{
            AlarmController.shared.addAlarm(fireDate: timePicker.date, name: name, isEnabled: localIsEnabled)
        }
        self.navigationController?.popViewController(animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func updateButton(){
        switch localIsEnabled {
        case true:
            enableDisable.titleLabel?.textColor = .black
            enableDisable.backgroundColor = .red
            enableDisable.setTitle("Disabled", for: .normal)
        case false:
            enableDisable.titleLabel?.textColor = .white
            enableDisable.backgroundColor = .green
            enableDisable.setTitle("Enabled", for: .normal)
        default:
            print("LocalIsEnabled Broke")
        }
    }
}

