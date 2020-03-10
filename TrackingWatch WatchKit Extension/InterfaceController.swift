//
//  InterfaceController.swift
//  TrackingWatch WatchKit Extension
//
//  Created by Алексей Пархоменко on 24.02.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    @IBOutlet weak var time: WKInterfaceLabel!
    @IBOutlet weak var steps: WKInterfaceLabel!
    @IBOutlet weak var distance: WKInterfaceLabel!
    @IBOutlet weak var button: WKInterfaceButton!
    
    var isTrackingRunning: Bool = false
    let activityService = ActivityService()
    
    @IBAction func updateTapped() {
        if isTrackingRunning {
            self.steps.setText("Steps : N/A")
            self.distance.setText("Distance : N/A")
            self.time.setText("Time : N/A")
            button.setTitle("Start Updating")
            activityService.stopMonitoring()
        } else {
            button.setTitle("Stop Updating")
            activityService.startMonitoring()
        }
        isTrackingRunning = !isTrackingRunning
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        activityService.delegate = self
        activityService.isStepCountingAvailable ? steps.setTextColor(.green) : steps.setTextColor(.red)
        activityService.isDistanceAvailable ? distance.setTextColor(.green) : distance.setTextColor(.red)
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}

extension InterfaceController: CountingDelegate {
    func countingParams(steps: Int, distance: Double, workoutSeconds: Int) {
        self.steps.setText("Steps : \(steps)")
        self.distance.setText("Distance : \(distance.getDistanceString())")
        self.time.setText("Time : \(workoutSeconds.secondsToHoursMinutesSeconds())")
    }
}
