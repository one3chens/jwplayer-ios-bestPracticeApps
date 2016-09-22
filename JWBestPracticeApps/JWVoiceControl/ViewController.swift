//
//  ViewController.swift
//  JWVoiceControl
//
//  Created by Karim Mourra on 9/9/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

import UIKit
import Intents

class ViewController: JWBasicVideoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        INPreferences.requestSiriAuthorization { (authorizationStatus) in}
    }
    
    public func handle(command: String) {
        if command == "play" {
            print("playing")
            self.player.play()
        } else if command == "pause" {
            print("pausing")
            self.player.pause()
        }
    }
}

