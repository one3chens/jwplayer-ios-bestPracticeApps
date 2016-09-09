//
//  ViewController.swift
//  JWPlayer VR Developer Demo
//
//  Created by Rik Heijdens on 9/8/16.
//  Copyright © 2016 JW Player. All rights reserved.
//

import UIKit
import JWPlayerVRSDK

class ViewController: UIViewController, JWVrVideoViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    let stereoModes = ["Monoscopic", "Top-Bottom (Over-under)", "Left-Right (Side-by-side)"] // Matches the StereoMode enum
    let cellReuseIdentifier = "cell"
    let defaultStream = "https://content.jwplatform.com/manifests/G3ADNSa0.m3u8"
    let defaultStereoMode = 1 // Top-Bottom (Over-under)
    
    var videoView:JWVrVideoView!
    var streamInputView:UITextField!
    var selectedRowPath:NSIndexPath!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = UIScreen.mainScreen().bounds

        // Initialize a JWVrVideoView with 16:9 dimensions.
        videoView = JWVrVideoView.init(frame: CGRectMake(0, UIApplication.sharedApplication().statusBarFrame.height,
            bounds.size.width, (bounds.size.width / 16 * 9)))
        
        // Register this ViewController as delegate on the JWVrVideoView.
        videoView.delegate = self
        
        // Add the JWVrVideoView to the layout
        self.view.addSubview(videoView)
        
        let streamUrlLabel = UILabel.init(frame: CGRectMake(20, videoView.frame.origin.y + videoView.frame.size.height + 20, bounds.size.width - 40, 20))
        streamUrlLabel.text = "STREAM URL"
        streamUrlLabel.textColor = UIColor.grayColor()
        self.view.addSubview(streamUrlLabel)
        
        // Initialize a TextField that can be used for StreamInput.
        streamInputView = UITextField.init(frame: CGRectMake(20, streamUrlLabel.frame.origin.y + streamUrlLabel.frame.size.height + 10, bounds.size.width - 40, 31))
        streamInputView.placeholder = "URL"
        streamInputView.clearButtonMode = UITextFieldViewMode.WhileEditing
        streamInputView.borderStyle = UITextBorderStyle.RoundedRect
        streamInputView.delegate = self
        streamInputView.text = defaultStream
        self.view.addSubview(streamInputView)
        
        let streamModeLabel = UILabel.init(frame: CGRectMake(20, streamInputView.frame.origin.y + streamInputView.frame.size.height + 20, bounds.size.width - 40, 20));
        streamModeLabel.text = "STEREO MODE"
        streamModeLabel.textColor = UIColor.grayColor()
        self.view.addSubview(streamModeLabel)
        
        // Initialize a TableView that will be used to select the stereo mode.
        let streamModeTableView = UITableView.init(frame: CGRectMake(20, streamModeLabel.frame.origin.y + streamModeLabel.frame.size.height, bounds.size.width - 40, 150))
        streamModeTableView.delegate = self
        streamModeTableView.dataSource = self
        streamModeTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        streamModeTableView.contentInset = UIEdgeInsetsZero
        streamModeTableView.layoutMargins = UIEdgeInsetsZero
        streamModeTableView.scrollEnabled = false
        // Select a default
        tableView(streamModeTableView, didSelectRowAtIndexPath: NSIndexPath.init(forRow: defaultStereoMode, inSection: 0))
        self.view.addSubview(streamModeTableView)
        
        // Initialize a button that loads the stream
        let loadButton = UIButton.init(frame: CGRectMake(20, streamModeTableView.frame.origin.y + streamModeTableView.frame.size.height + 10, 80, 40))
        loadButton.setTitle("Setup", forState: UIControlState.Normal)
        loadButton.addTarget(self, action: #selector(load), forControlEvents: UIControlEvents.TouchDown)
        loadButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        loadButton.layer.cornerRadius = 5
        loadButton.layer.borderWidth = 1
        loadButton.layer.borderColor = UIColor.blueColor().CGColor
        self.view.addSubview(loadButton)
        
        // Ensure media is loaded on the player
        load()
    }
    
    /**
        Loads Media
    */
    func load() {
        let mediaUrl = streamInputView?.text
        if (mediaUrl != nil && mediaUrl?.characters.count > 1) {
            // Sanitize the mediaUrl, loading nil or empty URLs will make the player unstable.
            videoView.load(mediaUrl, withStereoMode: StereoMode.init(rawValue: selectedRowPath.row)!)
            videoView.play()
        } else {
            let alert = UIAlertController(title: "Error", message: "Please enter a Stream URL", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func preferredInterfaceOrientationForPresentation() -> UIInterfaceOrientation {
        return UIInterfaceOrientation.Portrait
    }
    
    override func shouldAutorotate() -> Bool {
        // This ViewController only supports landscape layout when the JWVrVideoView is in fullscreen.
        return videoView.isInFullscreen || UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)
    }
    
    // MARK: JWVrVideoViewDelegate implementation.
    
    /**
        Called by the JWVrVideoView when the user uses the cardboard trigger or
        interacts with the JWVrVideoView.
    */
    func onCardboardTrigger() {
        NSLog("onCardboardTrigger()")
    }
    
    /**
        Called when the player transitions into the idle state.
     
        - Parameter oldState: The state the player was in before transitioning into the idle state.
    */
    func onIdle(oldState: String!) {
        NSLog("onIdle(oldState), oldState: " + oldState)
    }
    
    /**
        Called when the player transitions into the play state.
 
        - Parameter oldState: The state the player was in before transitioning into the play state.
    */
    func onPlay(oldState: String!) {
        NSLog("onPlay(oldState), oldState: " + oldState)
    }
    
    /**
        Called when the player transitions into the buffer state.
 
        - Parameter oldState: The state the player was in before transitioning into the buffer state.
    */
    func onBuffer(oldState: String!) {
        NSLog("onBuffer(oldState), oldState: " + oldState)
    }
    
    /**
        Called when the player transitions into the paused state.
 
        - Parameter oldState: The state the player was in before transitioning into the paused state.
    */
    func onPause(oldState: String!) {
        NSLog("onPause(oldState), oldState: " + oldState)
    }
    
    /**
        Called when the player transitions into the completed state.
 
        - Parameter oldState: The state the player was in before transitioning into the completed state.
    */
    func onComplete(oldState: String!) {
        NSLog("onComplete(oldState), oldState: " + oldState)
    }
    
    /**
        Called by the JWVrVideoView when the VR Mode has been toggled.
 
        - Parameter enabled: Whether the VRMode has been enabled or disabled.
    */
    func onVRModeEnabled(enabled: Bool) {
        NSLog("onVRModeEnabled(enabled), enabled: " + (enabled ? "true" : "false"))
    }
    
    /**
        Called by the JWVrVideoView when the fullscreen state has been toggled.
     
        - Parameter fullscreen: Whether the player is in fullscreen mode.
    */
    func onFullscreenToggled(fullscreen: Bool) {
        NSLog("onFullscreenToggled(fullscreen), fullscreen: " + (fullscreen ? "true" : "false"))
        if (!fullscreen) {
            // Force portrait orientation when exiting fullscreen.
            let orientation = UIInterfaceOrientation.Portrait.rawValue
            UIDevice.currentDevice().setValue(orientation, forKey: "orientation")
            UIViewController.attemptRotationToDeviceOrientation()
        }
    }
    
    // MARK: UITextViewDelegate implementation.
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = event?.allTouches()?.first
        if (streamInputView.isFirstResponder() && touch!.view != streamInputView) {
            streamInputView.resignFirstResponder()
        }
    }
    
    // MARK: UITableViewDataSource implementation.
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier)! as UITableViewCell
        cell.textLabel?.text = stereoModes[indexPath.row]
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.separatorInset = UIEdgeInsetsZero
        cell.layoutMargins = UIEdgeInsetsZero
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stereoModes.count
    }

    // MARK: UITableViewDelegate implementation.
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Ensure the keyboard is hidden after selecting a streamMode.
        streamInputView.resignFirstResponder()
        
        if let oldRow = selectedRowPath?.row {
            if (oldRow == indexPath.row) {
                return; // Nothing to do.
            }
            
            let oldCell = tableView.cellForRowAtIndexPath(selectedRowPath)
            if (oldCell?.accessoryType == UITableViewCellAccessoryType.Checkmark) {
                oldCell?.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
        let newCell = tableView.cellForRowAtIndexPath(indexPath)
        if (newCell?.accessoryType == UITableViewCellAccessoryType.None) {
            newCell?.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        selectedRowPath = indexPath
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.layoutMargins = UIEdgeInsetsZero
    }

}