//
//  PlaybackHandler.swift
//  JWBestPracticeApps
//
//  Created by JWP Admin on 9/20/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

import Foundation
import Intents

class PlaybackHandler: NSObject, INStartPhotoPlaybackIntentHandling {
    
    public func handle(startPhotoPlayback intent: INStartPhotoPlaybackIntent, completion: @escaping(INStartPhotoPlaybackIntentResponse) -> Void) {
        completion(INStartPhotoPlaybackIntentResponse.init(code: INStartPhotoPlaybackIntentResponseCode.continueInApp, userActivity: nil))
        
    }
    
    func confirm(startPhotoPlayback intent: INStartPhotoPlaybackIntent, completion: @escaping(INStartPhotoPlaybackIntentResponse) -> Void) {
        completion(INStartPhotoPlaybackIntentResponse.init(code: INStartPhotoPlaybackIntentResponseCode.continueInApp, userActivity: nil))
    }
}
