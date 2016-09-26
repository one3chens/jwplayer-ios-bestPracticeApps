//
//  IntentHandler.swift
//  VoicerExtension
//
//  Created by JWP Admin on 9/21/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

import Intents

class IntentHandler: INExtension, INPauseWorkoutIntentHandling, INResumeWorkoutIntentHandling, INStartWorkoutIntentHandling, INEndWorkoutIntentHandling {
    
    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    func resolveWorkoutName(forStartWorkout intent: INStartWorkoutIntent, with completion: @escaping (INSpeakableStringResolutionResult) -> Void) {
        print("\n=====resolve forStartWorkout")
        print("\nspoken: \(intent.workoutName?.spokenPhrase)")
        print("\nidentifier1: \(intent.identifier)")
        print("\nidentifier2: \(intent.workoutName?.identifier)")
        
        if (intent.workoutName?.spokenPhrase == "casting") {
            let userDefaults = UserDefaults.init(suiteName: "group.com.jwplayer.wormhole")
            let castingDevices = userDefaults?.value(forKey: "castingDevices") as? [String?]
            if (castingDevices == nil || castingDevices?.count == 0) {
                completion(INSpeakableStringResolutionResult.success(with: intent.workoutName!))
            }
            var speakableCastingDevices = [INSpeakableString]()
            for deviceName in castingDevices! {
                let speakableDeviceName = INSpeakableString.init(identifier: deviceName!, spokenPhrase: deviceName!, pronunciationHint: nil)
                speakableCastingDevices.append(speakableDeviceName)
            }
            completion(INSpeakableStringResolutionResult.disambiguation(with: speakableCastingDevices))
        } else if (intent.workoutName != nil) {
            print("****** workout name: \(intent.workoutName)")
            completion(INSpeakableStringResolutionResult.success(with: intent.workoutName!))
        } else {
            print("++++++ needs more info")
            let seeking = INSpeakableString.init(identifier: "1", spokenPhrase: "seeking", pronunciationHint: "seec")
            let casting = INSpeakableString.init(identifier: "2", spokenPhrase: "casting", pronunciationHint: "cas ting")
            let playing = INSpeakableString.init(identifier: "3", spokenPhrase: "playing", pronunciationHint: "pley ing")
            completion(INSpeakableStringResolutionResult.disambiguation(with: [seeking, casting, playing]))
        }
    }
    
//    func resolveGoalValue(forStartWorkout intent: INStartWorkoutIntent, with completion: @escaping (INDoubleResolutionResult) -> Void) {
//        print("resolve goal value \(intent.goalValue)")
//        if (intent.goalValue != nil) {
//            completion(INDoubleResolutionResult.success(with: intent.goalValue!))
//        } else {
//            completion(INDoubleResolutionResult.confirmationRequired(with: 5))
//        }
//    }
    
//    func resolveWorkoutGoalUnitType(forStartWorkout intent: INStartWorkoutIntent, with completion: @escaping (INWorkoutGoalUnitTypeResolutionResult) -> Void) {
//        let unitType = intent.workoutGoalUnitType.rawValue
//        print("resolve goal unit: \(unitType)")//handle mintus and seconds
//        completion(INWorkoutGoalUnitTypeResolutionResult.success(with: INWorkoutGoalUnitType.second))
//    }
    
//    func confirm(startWorkout intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
//        print("confirmation forStartWorkout")
//        print("\nspoken: \(intent.workoutName?.spokenPhrase)")
//        
//        let userActivity = NSUserActivity.init(activityType: "pause")
//        completion(INStartWorkoutIntentResponse.init(code: INStartWorkoutIntentResponseCode.continueInApp, userActivity: userActivity))
//    }
    
    func handle(endWorkout intent: INEndWorkoutIntent, completion: @escaping (INEndWorkoutIntentResponse) -> Void) {
        let userActivity = NSUserActivity.init(activityType: "end")
        completion(INEndWorkoutIntentResponse.init(code: INEndWorkoutIntentResponseCode.continueInApp, userActivity: userActivity))
    }
    
    func handle(startWorkout intent: INStartWorkoutIntent, completion: @escaping (INStartWorkoutIntentResponse) -> Void) {
        print("handle forStartWorkout")
        print("\nspoken: \(intent.workoutName?.spokenPhrase)")
        let userActivity = NSUserActivity.init(activityType: "seek")
//        userActivity.userInfo = ["intent": intent]
        completion(INStartWorkoutIntentResponse.init(code: INStartWorkoutIntentResponseCode.continueInApp, userActivity: userActivity))
    }
    
    //    func resolveIsOpenEnded(forStartWorkout intent: INStartWorkoutIntent, with completion: @escaping (INBooleanResolutionResult) -> Void) {
    //
    //    }
    
    func handle(pauseWorkout intent: INPauseWorkoutIntent, completion: @escaping(INPauseWorkoutIntentResponse) -> Void) {
        let workoutName = intent.workoutName
        print("pauseWorkout \n \(workoutName?.spokenPhrase)")
        print("identifier \(workoutName?.identifier)")
        let userActivity = NSUserActivity.init(activityType: "pause")
        completion(INPauseWorkoutIntentResponse.init(code: INPauseWorkoutIntentResponseCode.continueInApp, userActivity: userActivity))
    }
    
//    func resolveWorkoutName(forPauseWorkout intent: INPauseWorkoutIntent, with completion: @escaping(INSpeakableStringResolutionResult) -> Void) {
//        print("resolve forPauseWorkout")
//        print("spoken: \(intent.workoutName?.spokenPhrase)")
//        if (intent.workoutName != nil) {
//            print("****** workOut name: \(intent.workoutName)")
//            completion(INSpeakableStringResolutionResult.success(with: intent.workoutName!))
//        } else {
//            print("++++++ needs more info")
//            let pause = INSpeakableString.init(identifier: "1", spokenPhrase: "pause", pronunciationHint: "paws")
//            let play = INSpeakableString.init(identifier: "2", spokenPhrase: "play", pronunciationHint: "play")
//            completion(INSpeakableStringResolutionResult.disambiguation(with: [pause, play]))
//        }
//    }
    
//    func confirm(pauseWorkout intent: INPauseWorkoutIntent, completion: @escaping(INPauseWorkoutIntentResponse) -> Void) {
//        print("confirm forPauseWorkout")
//        let userActivity = NSUserActivity.init(activityType: "pause")
//        completion(INPauseWorkoutIntentResponse.init(code: INPauseWorkoutIntentResponseCode.ready, userActivity: userActivity))
//    }
    
    func handle(resumeWorkout intent: INResumeWorkoutIntent, completion: @escaping(INResumeWorkoutIntentResponse) -> Void) {
        print("handle resumeWorkout called \(intent.workoutName)")
        let userActivity = NSUserActivity.init(activityType: "resume")
        completion(INResumeWorkoutIntentResponse.init(code: INResumeWorkoutIntentResponseCode.continueInApp, userActivity: userActivity))
    }
    
//    func resolveWorkoutName(forResumeWorkout intent: INResumeWorkoutIntent, with completion: @escaping(INSpeakableStringResolutionResult) -> Void) {
//        print("resolve forResumeWorkout")
//    }
//    
//    func confirm(resumeWorkout intent: INResumeWorkoutIntent, completion: @escaping(INResumeWorkoutIntentResponse) -> Void) {
//        print("confirm forResumeWorkout")
//    }
}

