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
    var mockAlarms: [Alarm]{
        let alarm1 = Alarm(fireDate: Date(), name: "Test 1", isEnabled: true)
        let alarm2 = Alarm(fireDate: Date(), name: "Test 2", isEnabled: false)
        return [alarm1, alarm2]
    }
    
    func addAlarm(fireDate: Date, name: String, isEnabled: Bool){
        let newAlarm = Alarm(fireDate: fireDate, name: name, isEnabled: isEnabled)
        alarms.append(newAlarm)
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
    func toggleIsOn(alarm: Alarm){
        alarm.isEnabled = !alarm.isEnabled
    }
}
