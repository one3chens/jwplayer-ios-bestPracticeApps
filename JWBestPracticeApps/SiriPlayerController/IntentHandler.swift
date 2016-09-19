//
//  IntentHandler.swift
//  SiriPlayerController
//
//  Created by JWP Admin on 9/10/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

import Intents

class IntentHandler: INExtension, INStartPhotoPlaybackIntentHandling {

    override func handler(for intent: INIntent) -> Any {
        return self
    }
    
    /*!
     @brief handling method
     
     @abstract Execute the task represented by the INStartPhotoPlaybackIntent that's passed in
     @discussion This method is called to actually execute the intent. The app must return a response for this intent.
     
     @param  startPhotoPlaybackIntent The input intent
     @param  completion The response handling block takes a INStartPhotoPlaybackIntentResponse containing the details of the result of having executed the intent
     
     @see  INStartPhotoPlaybackIntentResponse
     */
    public func handle(startPhotoPlayback intent: INStartPhotoPlaybackIntent, completion: (INStartPhotoPlaybackIntentResponse) -> Void) {
        print("start playback")
        let response = INStartPhotoPlaybackIntentResponse.init(code: .continueInApp, userActivity: nil)
        completion(response)
    }
    
    public func confirm(startPhotoPlayback intent: INStartPhotoPlaybackIntent, completion: (INStartPhotoPlaybackIntentResponse) -> Void) {
        print("confirm playback")
    }
    
    func resolveAlbumName(forStartPhotoPlayback intent: INStartPhotoPlaybackIntent, with completion: (INStringResolutionResult) -> Void) {
        
    }
    
    func resolvePeopleInPhoto(forStartPhotoPlayback intent: INStartPhotoPlaybackIntent, with completion: ([INPersonResolutionResult]) -> Void) {
        
    }
    
    func resolveLocationCreated(forStartPhotoPlayback intent: INStartPhotoPlaybackIntent, with completion: (INPlacemarkResolutionResult) -> Void) {
        
    }
    
    func resolveDateCreated(forStartPhotoPlayback intent: INStartPhotoPlaybackIntent, with completion: (INDateComponentsRangeResolutionResult) -> Void) {
        
    }

    
    /*
    // MARK: - INSendMessageIntentHandling
    
    // Implement resolution methods to provide additional information about your intent (optional).
    func resolveRecipients(forSendMessage intent: INSendMessageIntent, with completion: @escaping ([INPersonResolutionResult]) -> Void) {
        if let recipients = intent.recipients {
            
            // If no recipients were provided we'll need to prompt for a value.
            if recipients.count == 0 {
                completion([INPersonResolutionResult.needsValue()])
                return
            }
            
            var resolutionResults = [INPersonResolutionResult]()
            for recipient in recipients {
                let matchingContacts = [recipient] // Implement your contact matching logic here to create an array of matching contacts
                switch matchingContacts.count {
                case 2  ... Int.max:
                    // We need Siri's help to ask user to pick one from the matches.
                    resolutionResults += [INPersonResolutionResult.disambiguation(with: matchingContacts)]
                    
                case 1:
                    // We have exactly one matching contact
                    resolutionResults += [INPersonResolutionResult.success(with: recipient)]
                    
                case 0:
                    // We have no contacts matching the description provided
                    resolutionResults += [INPersonResolutionResult.unsupported()]
                    
                default:
                    break
                    
                }
            }
            completion(resolutionResults)
        }
    }
    
    func resolveContent(forSendMessage intent: INSendMessageIntent, with completion: @escaping (INStringResolutionResult) -> Void) {
        if let text = intent.content, !text.isEmpty {
            completion(INStringResolutionResult.success(with: text))
        } else {
            completion(INStringResolutionResult.needsValue())
        }
    }
    
    // Once resolution is completed, perform validation on the intent and provide confirmation (optional).
    
    func confirm(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        // Verify user is authenticated and your app is ready to send a message.
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .ready, userActivity: userActivity)
        completion(response)
    }
    
    // Handle the completed intent (required).
    
    func handle(sendMessage intent: INSendMessageIntent, completion: @escaping (INSendMessageIntentResponse) -> Void) {
        // Implement your application logic to send a message here.
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSendMessageIntent.self))
        let response = INSendMessageIntentResponse(code: .success, userActivity: userActivity)
        completion(response)
    }
    
    // Implement handlers for each intent you wish to handle.  As an example for messages, you may wish to also handle searchForMessages and setMessageAttributes.
    
    // MARK: - INSearchForMessagesIntentHandling
    
    func handle(searchForMessages intent: INSearchForMessagesIntent, completion: @escaping (INSearchForMessagesIntentResponse) -> Void) {
        // Implement your application logic to find a message that matches the information in the intent.
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSearchForMessagesIntent.self))
        let response = INSearchForMessagesIntentResponse(code: .success, userActivity: userActivity)
        // Initialize with found message's attributes
        response.messages = [INMessage(
            identifier: "identifier",
            content: "I am so excited about SiriKit!",
            dateSent: Date(),
            sender: INPerson(personHandle: INPersonHandle(value: "sarah@example.com", type: .emailAddress), nameComponents: nil, displayName: "Sarah", image: nil,  contactIdentifier: nil, customIdentifier: nil),
            recipients: [INPerson(personHandle: INPersonHandle(value: "+1-415-555-5555", type: .phoneNumber), nameComponents: nil, displayName: "John", image: nil,  contactIdentifier: nil, customIdentifier: nil)]
            )]
        completion(response)
    }
    
    // MARK: - INSetMessageAttributeIntentHandling
    
    func handle(setMessageAttribute intent: INSetMessageAttributeIntent, completion: @escaping (INSetMessageAttributeIntentResponse) -> Void) {
        // Implement your application logic to set the message attribute here.
        
        let userActivity = NSUserActivity(activityType: NSStringFromClass(INSetMessageAttributeIntent.self))
        let response = INSetMessageAttributeIntentResponse(code: .success, userActivity: userActivity)
        completion(response)
    }
 */
}

