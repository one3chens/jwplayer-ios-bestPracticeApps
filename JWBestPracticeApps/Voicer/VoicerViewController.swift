//
//  VoicerViewController.swift
//  JWBestPracticeApps
//
//  Created by Karim Mourra on 9/21/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

import UIKit
import Intents

class VoicerViewController: JWRemoteCastPlayerViewController {

    let userDefaults = UserDefaults.init(suiteName: "group.com.jwplayer.wormhole")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        INPreferences.requestSiriAuthorization { (authorizationStatus) in
        }
    }
    
    public func handle(intent: INIntent) {
        if intent is INPauseWorkoutIntent {
            let pauseIntent = intent as! INPauseWorkoutIntent
            self.handle(command: (pauseIntent.workoutName?.spokenPhrase)!, quantity: nil)
        } else if intent is INResumeWorkoutIntent {
            let resumeIntent = intent as! INResumeWorkoutIntent
            self.handle(command: (resumeIntent.workoutName?.spokenPhrase)!, quantity: nil)
        } else if intent is INStartWorkoutIntent {
            let seekIntent = intent as! INStartWorkoutIntent
            let seekPosition = UInt(seekIntent.goalValue!)
            self.handle(command: (seekIntent.workoutName?.spokenPhrase)!, quantity: seekPosition)
        } else if intent is INEndWorkoutIntent {
            let endCastingIntent = intent as! INEndWorkoutIntent
            self.handle(command: (endCastingIntent.workoutName?.spokenPhrase)!, quantity: 0)
        }
    }

    func handle(command: String, quantity: UInt?) {
        if command.lowercased() == "play" {
            self.player.play()
        } else if command.lowercased() == "pause" {
            self.player.pause()
        } else if command.lowercased() == "seeking" {
            self.player.seek(quantity!)
        } else if command.lowercased() == "casting" {
            self.castController.disconnect()
        } else {
            let castingDevice = self.obtainCastingDevice(name: command)
            if castingDevice != nil {
                self.castController.connect(to: castingDevice)
            }
        }
    }
    
    func obtainCastingDevice(name: String) -> JWCastingDevice? {
        for device in self.castController.availableDevices {
            let castDevice = device as! JWCastingDevice
            if castDevice.name == name {
                return castDevice
            }
        }
        return nil
    }
    
    // MARK: Cast Delegate Methods
    
    override func onCastingDevicesAvailable(_ devices: [JWCastingDevice]!) {
        super.onCastingDevicesAvailable(devices)
        self.prepareCastingDevices()
    }
    
    func prepareCastingDevices() {
        var castingDevices = [String]()
        for device in self.castController.availableDevices {
            castingDevices.append((device as! JWCastingDevice).name)
        }
        if castingDevices.count > 0 {
            self.userDefaults?.set(castingDevices, forKey: "castingDevices")
            self.userDefaults?.synchronize()
        }
    }
    
    override func onConnected(to device: JWCastingDevice!) {
        super.onConnected(to: device)
    }
    
    override func onCasting() {
        super.onCasting()
    }
    
    override func onCastingEnded(_ error: Error!) {
        super.onCastingEnded(error)
    }
    
    override func onCastingFailed(_ error: Error!) {
        super.onCastingFailed(error)
    }
    
    override func onDisconnected(fromCastingDevice error: Error!) {
        super.onDisconnected(fromCastingDevice: error)
    }
}
