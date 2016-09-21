//
//  IntentHandler.swift
//  VoicerExtension
//
//  Created by JWP Admin on 9/21/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

import Intents

class IntentHandler: INExtension, INPauseWorkoutIntentHandling, INResumeWorkoutIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        print("handler called")
        return self
    }
    
    func handle(pauseWorkout intent: INPauseWorkoutIntent, completion: @escaping(INPauseWorkoutIntentResponse) -> Void) {
        print("handle pauseWorkout called \(intent.workoutName)")
        let userActivity = NSUserActivity.init(activityType: "pause")
        userActivity.userInfo = NSDictionary.init(object: "rando", forKey: "randkey" as NSCopying) as? [AnyHashable : Any]
        completion(INPauseWorkoutIntentResponse.init(code: INPauseWorkoutIntentResponseCode.ready, userActivity: userActivity))
    }
    
    func handle(resumeWorkout intent: INResumeWorkoutIntent, completion: @escaping(INResumeWorkoutIntentResponse) -> Void) {
        print("handle resumeWorkout called \(intent.workoutName)")
        let userActivity = NSUserActivity.init(activityType: "resume")
        completion(INResumeWorkoutIntentResponse.init(code: INResumeWorkoutIntentResponseCode.continueInApp, userActivity: userActivity))
    }
}

