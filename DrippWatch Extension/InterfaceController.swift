//
//  InterfaceController.swift
//  DrippWatch Extension
//
//  Created by Brandon Hudson on 1/30/16.
//  Copyright © 2016 Henry Saniuk. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    // Our WatchConnectivity Session for communicating with the iOS app
    var watchSession : WCSession?
    
    @IBOutlet var playPauseButton: WKInterfaceButton!
    @IBOutlet var stopButton: WKInterfaceButton!
    @IBOutlet var messagelabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
       
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }
    
    @IBAction func playPauseTapped() {
        if let message : String = "play" {
            do {
                try watchSession?.updateApplicationContext(
                    ["message" : message]
                )
            } catch let error as NSError {
                NSLog("Updating the context failed: " + error.localizedDescription)
            }
        }
    }
    
    @IBAction func stopTapped() {
        if let message : String = "stop" {
            do {
                try watchSession?.updateApplicationContext(
                    ["message" : message]
                )
            } catch let error as NSError {
                NSLog("Updating the context failed: " + error.localizedDescription)
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        if(WCSession.isSupported()){
            watchSession = WCSession.defaultSession()
            // Add self as a delegate of the session so we can handle messages
            watchSession!.delegate = self
            watchSession!.activateSession()
        }
    }
    
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]){
        let message : String = applicationContext["message"] as! String
        messagelabel.setText(message)
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
