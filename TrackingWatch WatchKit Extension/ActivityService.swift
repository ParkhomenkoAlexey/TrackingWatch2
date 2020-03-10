//
//  ActivityService.swift
//  TrackingWatch WatchKit Extension
//
//  Created by Алексей Пархоменко on 10.03.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit
import CoreMotion

protocol CountingDelegate {
    func countingParams(steps: Int, distance: Double, workoutSeconds: Int)
}

class ActivityService {
    
    let pedometer = CMPedometer()
    
    var numberOfSteps: Int! = 0
    var distance: Double! = 0.0
    var startDate: Date? = nil
    
    var delegate: CountingDelegate?
    
    var isStepCountingAvailable: Bool {
        get {
            return CMPedometer.isStepCountingAvailable()
        }
    }
    
    var isDistanceAvailable: Bool {
        get {
            return CMPedometer.isDistanceAvailable()
        }
    }
    
    func startMonitoring() {
        startDate = Date()
        guard checkAuthStatus(), isStepCountingAvailable, isDistanceAvailable else {
            fatalError("cant' auth")
                }
        pedometer.startUpdates(from: Date()) { (pedometerData, error) in
        if let pedometerData = pedometerData {
            self.setPedometerData(pedData: pedometerData)
            self.delegate?.countingParams(steps: self.numberOfSteps, distance: self.distance, workoutSeconds: Date().secondsInBetweenDate(self.startDate))
            }
        }
    }
    
    private func setPedometerData(pedData: CMPedometerData) {
        self.numberOfSteps = Int(truncating: pedData.numberOfSteps)
        if let distance = pedData.distance {
            self.distance = Double(truncating: distance)
        }
    }
    
    private func checkAuthStatus() -> Bool {
        var pedometerAuth = false
        switch CMPedometer.authorizationStatus() {
        case .authorized:
            pedometerAuth = true
        default:
            break
        }
        return pedometerAuth
    }
    
    func stopMonitoring() {
        startDate = nil
        pedometer.stopUpdates()
        pedometer.stopEventUpdates()
    }
}
