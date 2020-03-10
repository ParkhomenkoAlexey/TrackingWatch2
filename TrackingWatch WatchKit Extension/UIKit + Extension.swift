//
//  UIKit + Extension.swift
//  TrackingWatch WatchKit Extension
//
//  Created by Алексей Пархоменко on 10.03.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import Foundation

extension Double {
    
    func getDistanceString() -> String {
        return String(format:"%02.02f mtr",self)
    }
}

extension Int {
    
    func secondsToHoursMinutesSeconds () -> String {
        let hours = self / 3600
        let min = (self % 3600) / 60
        let sec = (self % 3600) % 60
        
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, min, sec)
        } else {
            return String(format: "%02i:%02i", min, sec)
        }
    }
}

extension Date {
    func secondsInBetweenDate(_ date: Date?) -> Int {
        if date == nil
        {
            return 0
        }
        var diff = self.timeIntervalSinceNow - date!.timeIntervalSinceNow
        diff = fabs(diff)
        return Int(diff)
    }
}

