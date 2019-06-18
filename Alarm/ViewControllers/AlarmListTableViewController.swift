//
//  AlamListTableViewController.swift
//  Alarm
//
//  Created by Trevor Walker on 6/17/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import UIKit

class AlamListTableViewController: UITableViewController, AlarmScheduler {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AlarmController.shared.alarms.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? SwitchTableViewCell
            else {
                return UITableViewCell()
        }
        cell.cellDelegate = self
        cell.update(alarm: AlarmController.shared.alarms[indexPath.row])
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            AlarmController.shared.deleteAlarm(alarm: AlarmController.shared.alarms[indexPath.row])
            tableView.reloadData()
        }
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "alarmUpdate"{
            guard let destination = segue.destination as? AlarmDetailTableViewController else {return}
            guard let index = tableView.indexPathForSelectedRow else {return}
            destination.landingPad = AlarmController.shared.alarms[index.row]
        }
    }
}
extension AlamListTableViewController: SwitchTableViewDelegate{
    func switchChanged(cell: SwitchTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let alarm = AlarmController.shared.alarms[indexPath.row]
        AlarmController.shared.toggleIsOn(alarm: alarm)
        cell.update(alarm: alarm)
    }
    
    
}
