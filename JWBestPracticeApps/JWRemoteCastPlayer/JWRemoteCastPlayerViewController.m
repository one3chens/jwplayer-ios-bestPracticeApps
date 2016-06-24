//
//  JWRemoteCastPlayerViewController.m
//  JWBestPracticeApps
//
//  Created by Karim Mourra on 6/24/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

#import "JWRemoteCastPlayerViewController.h"

@interface JWRemoteCastPlayerViewController ()

@end

@implementation JWRemoteCastPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"1");
}

#pragma Mark - Session delegate methods

-(void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    __weak JWRemotePlayerViewController *weakSelf = self;
    if (message[JWRControlMessage]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf.player performSelector:NSSelectorFromString(message[JWRControlMessage])];
        });
    } else if (message[JWRSeekMessage]) {
        NSNumber *seekPercentage = message[JWRSeekMessage];
        CGFloat seekTime = (seekPercentage.floatValue / 100) * self.player.duration;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf.player seek:seekTime];
        });
    }
    [super session:session didReceiveMessage:message replyHandler:replyHandler];
}

#pragma Mark - Player delegate methods

-(void)onPlay
{
    [self.session sendMessage:@{JWRCallbackMessage: JWROnPlayCallback}
                 replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {}
                 errorHandler:^(NSError * _Nonnull error) {}];
}

#pragma Mark - Casting delegate methods

-(void)onCastingDevicesAvailable:(NSArray *)devices
{
    if(devices.count > 0 && !self.castingItem) {
        [self setUpCastingButton];
        [self updateForCastDeviceDisconnection];
    } else if(devices.count == 0) {
        self.navigationItem.rightBarButtonItems = nil;
    }
}

-(void)onConnectedToCastingDevice:(JWCastingDevice *)device
{
    [self updateForCastDeviceConnection];
}

-(void)onDisconnectedFromCastingDevice
{
    [self updateForCastDeviceDisconnection];
}

-(void)onConnectionTemporarilySuspended
{
    [self updateWhenConnectingToCastDevice];
}

-(void)onConnectionRecovered
{
    [self updateForCastDeviceConnection];
}

-(void)onConnectionFailed:(NSError *)error
{
    if(error) {
        NSLog(@"Connection Error: %@", error);
    }
    [self updateForCastDeviceDisconnection];
}

-(void)onCasting
{
    [self updateForCasting];
}

-(void)onCastingEnded:(NSError *)error
{
    if(error) {
        NSLog(@"Casting Error: %@", error);
    }
    [self updateForCastingEnd];
}

-(void)onCastingFailed:(NSError *)error
{
    if(error) {
        NSLog(@"Casting Error: %@", error);
    }
    [self updateForCastingEnd];
}

@end
