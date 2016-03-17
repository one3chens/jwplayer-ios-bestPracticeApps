# jwplayer-ios-bestPracticeApps

This repository is used to present objective-c code which can be used to achieve custom functionality with your JW Player. 
The JWBestPracticeApps XCode project is composed of several targets. Each target can be run separately as an app. 
Each target adds a level of complexity to the target named JWBestPracticeApps, which displays a basic JW Player with minimal customization. The classes in more advanced targets inherit from the classes in the more basic targets, to present relevant code without overwhelming the reader with basic code.
-- The target named JWAirPlay adds the necessary code to add an AirPlay button to your app, and cast via AirPlay.
-- The target named JWCasting adds the code necessary to cast our JW Player to a Chrome Cast device.
-- The target named JWRemoteController is an Apple Watch app capable of controlling the JW Player in the target named JWRemotePlayer.

Initial Set-up:
-- Import the JW Player iOS SDK to the project, and for each target add your JWPlayer key. For more instructions please visit the official JW Player Developer guide at http://developer.jwplayer.com/sdk/ios/docs/developer-guide/
-- For targets that require casting to Google ChromeCast, you must import a Google ChromeCast Framework, as well as all of its dependencies. T find out which frameworks to import please visit https://developers.google.com/cast/docs/ios_sender#setup
