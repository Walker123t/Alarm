//
//  Alarm.swift
//  Alarm
//
//  Created by Trevor Walker on 6/17/19.
//  Copyright © 2019 Trevor Walker. All rights reserved.
//

import Foundation
class Alarm{
    var fireDate: Date
    var fireTime: String{
        get{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            return dateFormatter.string(from: fireDate)
        } set(timeText){
            self.fireTime = timeText
        }
    }
    var name: String
    var isEnabled: Bool
    //let uuid: String
    
    init(fireDate: Date, name: String, isEnabled: Bool) {
        self.fireDate = fireDate
        self.name = name
        self.isEnabled = isEnabled
        //self.uuid = uuid
    }
}
extension Alarm: Equatable{
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.fireDate == rhs.fireDate && lhs.name == rhs.name && lhs.isEnabled == rhs.isEnabled
    }
    
    
}
