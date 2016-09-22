//
//  VoicerViewController.swift
//  JWBestPracticeApps
//
//  Created by JWP Admin on 9/21/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

import UIKit
import Intents

class VoicerViewController: JWRemoteCastPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        INPreferences.requestSiriAuthorization { (authorizationStatus) in
            print("Authorized \(authorizationStatus)")
        }
    }

    public func handle(command: String) {
        if command.lowercased() == "play" {
            print("playing")
            self.player.play()
        } else if command.lowercased() == "pause" {
            print("pausing")
            self.player.pause()
        }
    }
}
