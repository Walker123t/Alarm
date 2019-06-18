//
//  AlarmController.swift
//  Alarm
//
//  Created by Trevor Walker on 6/17/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import Foundation
import UserNotifications

protocol AlarmScheduler: class{
    func scheduleUserNotification(for alarm: Alarm)
    func cancelUserNotification(for alarm: Alarm)
}
extension AlarmScheduler{
    
    func scheduleUserNotification(for alarm: Alarm){
        
        let content = UNMutableNotificationContent()
        content.title = "Time to get up"
        content.body = "Your alarm named \(alarm.name) is going off!"
        content.sound = UNNotificationSound.default
        
        let components = Calendar.current.dateComponents([.hour, .minute], from: alarm.fireDate)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        let request = UNNotificationRequest(identifier: alarm.uuid, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error{
                print("Error scheduling local user notifications \(error.localizedDescription)  :  \(error)")
            }
        }
        
    }
    
    func cancelUserNotification(for alarm: Alarm){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [alarm.uuid])
    }
}
class AlarmController: AlarmScheduler{
    
    static var shared = AlarmController()
    var alarms: [Alarm] = []
    
    func addAlarm(fireDate: Date, name: String, isEnabled: Bool){
        let newAlarm = Alarm(fireDate: fireDate, name: name, isEnabled: isEnabled)
        alarms.append(newAlarm)
        if isEnabled{
            scheduleUserNotification(for: newAlarm)
        } else{
            return
        }
        save()
    }
    func update(alarm: Alarm, fireDate: Date, name: String, isEnabled: Bool){
        alarm.fireDate = fireDate
        alarm.name = name
        alarm.isEnabled = isEnabled
        if isEnabled{
            scheduleUserNotification(for: alarm)
        } else{
            cancelUserNotification(for: alarm)
        }
        save()
    }
    func deleteAlarm(alarm: Alarm){
        guard let index = AlarmController.shared.alarms.index(of: alarm) else {return}
        self.cancelUserNotification(for: alarm)
        save()
    }
    func toggleIsOn(alarm: Alarm){
        alarm.isEnabled = !alarm.isEnabled
        
        if alarm.isEnabled{
            scheduleUserNotification(for: alarm)
        } else{
            cancelUserNotification(for: alarm)
        }
    }
    func createFileURL() -> URL{
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("alarms.json")
        return fileURL
    }
    func save(){
        let jsonEncoder = JSONEncoder()
        do{
            let jsonPlaylist = try jsonEncoder.encode(alarms)
            try jsonPlaylist.write(to: createFileURL())
        } catch let encodingError {
            print("error encoding JSON \(encodingError.localizedDescription)")
        }
    }
    func load(){
        let jsonDecoder = JSONDecoder()
        do{
            let jsonData = try Data(contentsOf: createFileURL())
            let decodedPlaylists = try jsonDecoder.decode([Alarm].self, from: jsonData)
            alarms = decodedPlaylists
        } catch let decodingError{
            print("error decoding JSON \(decodingError.localizedDescription)")
        }
    }
}
