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
        print("handler called \(intent.identifier)")
        return self
    }
    
    func handle(pauseWorkout intent: INPauseWorkoutIntent, completion: @escaping(INPauseWorkoutIntentResponse) -> Void) {
        let workoutName = intent.workoutName
        print("pauseWorkout \n \(workoutName?.spokenPhrase)")
        print("identifier \(workoutName?.identifier)")
        let userActivity = NSUserActivity.init(activityType: "pause")
        completion(INPauseWorkoutIntentResponse.init(code: INPauseWorkoutIntentResponseCode.continueInApp, userActivity: userActivity))
    }
    
    func resolveWorkoutName(forPauseWorkout intent: INPauseWorkoutIntent, with completion: @escaping(INSpeakableStringResolutionResult) -> Void) {
        print("resolve forPauseWorkout")
        if (intent.workoutName != nil) {
            print("workOut name: \(intent.workoutName)")
            completion(INSpeakableStringResolutionResult.success(with: intent.workoutName!))
        } else {
            let pause = INSpeakableString.init(identifier: "1", spokenPhrase: "pause", pronunciationHint: "paws")
            let play = INSpeakableString.init(identifier: "2", spokenPhrase: "play", pronunciationHint: "play")
            completion(INSpeakableStringResolutionResult.disambiguation(with: [pause, play]))
        }
    }
    
    func confirm(pauseWorkout intent: INPauseWorkoutIntent, completion: @escaping(INPauseWorkoutIntentResponse) -> Void) {
        let userActivity = NSUserActivity.init(activityType: "pause")
        completion(INPauseWorkoutIntentResponse.init(code: INPauseWorkoutIntentResponseCode.ready, userActivity: userActivity))
        print("confirm forPauseWorkout")
    }
    
    func handle(resumeWorkout intent: INResumeWorkoutIntent, completion: @escaping(INResumeWorkoutIntentResponse) -> Void) {
        print("handle resumeWorkout called \(intent.workoutName)")
        let userActivity = NSUserActivity.init(activityType: "resume")
        completion(INResumeWorkoutIntentResponse.init(code: INResumeWorkoutIntentResponseCode.continueInApp, userActivity: userActivity))
    }
    
    func resolveWorkoutName(forResumeWorkout intent: INResumeWorkoutIntent, with completion: @escaping(INSpeakableStringResolutionResult) -> Void) {
        print("resolve forResumeWorkout")
    }
    
    func confirm(resumeWorkout intent: INResumeWorkoutIntent, completion: @escaping(INResumeWorkoutIntentResponse) -> Void) {
        print("confirm forResumeWorkout")
    }
}

