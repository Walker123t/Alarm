//
//  AlarmController.swift
//  Alarm
//
//  Created by Trevor Walker on 6/17/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import Foundation

class AlarmController{
    
    static var shared = AlarmController()
    var alarms: [Alarm] = []
    
    func addAlarm(fireDate: Date, name: String, isEnabled: Bool) -> Alarm{
        let newAlarm = Alarm(fireDate: fireDate, name: name, isEnabled: isEnabled)
        alarms.append(newAlarm)
        return newAlarm
    }
    func update(alarm: Alarm, fireDate: Date, name: String, isEnabled: Bool){
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.isEnabled = isEnabled
    }
    func deleteAlarm(alarm: Alarm){
        guard let index = alarms.firstIndex(of: alarm) else {return}
        alarms.remove(at: index)
    }
}
