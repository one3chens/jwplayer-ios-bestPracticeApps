//
//  ViewController.swift
//  JWVoiceControl
//
//  Created by Karim Mourra on 9/9/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

import UIKit
import Intents

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        INPreferences.requestSiriAuthorization { (authorizationStatus) in
            print("Authorized \(authorizationStatus)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

