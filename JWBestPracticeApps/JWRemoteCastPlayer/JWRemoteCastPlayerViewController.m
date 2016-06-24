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
}

#pragma Mark - Session delegate methods

- (void)sessionReachabilityDidChange:(WCSession *)session
{
//    NSLog(@"activation complete");
    if (self.availableDevices.count && session.reachable) {
//        NSLog(@"reachable");
        [self updateDeviceListOnWatch:self.availableDevices];
    }
}

-(void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    if (message[JWRCastDeviceDisconnect]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [self.castController disconnect];
        });
    } else if (message[JWRCastDeviceSelected]) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSInteger index = ((NSNumber *)message[JWRCastDeviceSelected]).integerValue;
            [self.castController connectToDevice:self.availableDevices[index]];
        });
    } else {
        [super session:session didReceiveMessage:message replyHandler:replyHandler];
    }
}

#pragma Mark - Casting delegate methods

-(void)onCastingDevicesAvailable:(NSArray *)devices
{
    NSLog(@"onCastingDevicesAvailable");
    [self updateDeviceListOnWatch:devices];
    [super onCastingDevicesAvailable:devices];
}

- (void)updateDeviceListOnWatch:(NSArray *)devices
{
    NSMutableArray *deviceNames = [NSMutableArray new];
    [devices enumerateObjectsUsingBlock:^(JWCastingDevice *device, NSUInteger idx, BOOL * _Nonnull stop) {
        [deviceNames addObject:device.name];
    }];
    [self.session sendMessage:@{JWRCastDevicesAvailableCallback: deviceNames}
                 replyHandler:^(NSDictionary<NSString *,id> * _Nonnull replyMessage) {}
                 errorHandler:^(NSError * _Nonnull error) {}];
}

-(void)onConnectedToCastingDevice:(JWCastingDevice *)device
{
//    [self updateForCastDeviceConnection];
    [super onConnectedToCastingDevice:device];
    [self.castController cast];
}

-(void)onDisconnectedFromCastingDevice:(NSError *)error
{
//    [self updateForCastDeviceDisconnection];
    
    [super onDisconnectedFromCastingDevice:error];
}

-(void)onConnectionTemporarilySuspended
{
//    [self updateWhenConnectingToCastDevice];
    [super onConnectionTemporarilySuspended];
}

-(void)onConnectionRecovered
{
//    [self updateForCastDeviceConnection];
    [super onConnectionRecovered];
}

-(void)onConnectionFailed:(NSError *)error
{
    if(error) {
        NSLog(@"Connection Error: %@", error);
    }
//    [self updateForCastDeviceDisconnection];
    [super onConnectionFailed:error];
}

-(void)onCasting
{
//    [self updateForCasting];
    [super onCasting];
    [self.player play];
}

-(void)onCastingEnded:(NSError *)error
{
    if(error) {
        NSLog(@"Casting Error: %@", error);
    }
//    [self updateForCastingEnd];
    [self.castController disconnect];
    [super onCastingEnded:error];
}

-(void)onCastingFailed:(NSError *)error
{
    if(error) {
        NSLog(@"Casting Error: %@", error);
    }
//    [self updateForCastingEnd];
    [super onCastingFailed:error];
}

@end
