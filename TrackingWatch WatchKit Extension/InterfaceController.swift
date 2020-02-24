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
    
    
    @IBAction func updateTapped() {
        if isTrackingRunning {
            button.setTitle("Start Updating")
        } else {
            button.setTitle("Stop Updating")
        }
        isTrackingRunning = !isTrackingRunning
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
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
