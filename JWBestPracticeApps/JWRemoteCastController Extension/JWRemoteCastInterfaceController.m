//
//  JWRemoteCastInterfaceController.m
//  JWBestPracticeApps
//
//  Created by Karim Mourra on 6/24/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

#import "JWRemoteCastInterfaceController.h"

@interface JWRemoteCastInterfaceController ()

@end

@implementation JWRemoteCastInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
}

- (void)willActivate {
    [super willActivate];
}

- (void)didDeactivate {
    [super didDeactivate];
}

#pragma Mark - Handle user activity on phone

-(void)session:(WCSession *)session didReceiveMessage:(NSDictionary<NSString *,id> *)message replyHandler:(void (^)(NSDictionary<NSString *,id> * _Nonnull))replyHandler
{
    __weak JWRemoteInterfaceController* weakSelf = self;
    if (message[JWRCallbackMessage]) {
        NSString *callback = message[JWRCallbackMessage];
        if ([callback isEqualToString:JWROnTimeCallback]) {
            NSNumber *position = message[JWROnTimePosition];
            NSNumber *duration = message[JWROnTimeDuration];
            self.currentTimePercentage = (position.floatValue/duration.floatValue)*100;
            if (!self.seeking) {
                [self.hiddenSeeker setSelectedItemIndex:self.currentTimePercentage];
            }
        } else if ([callback isEqualToString:JWROnPlayCallback]) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [weakSelf handleVideoPlay];
            });
        } else if ([callback isEqualToString:JWROnPauseCallback]) {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [weakSelf handleVideoPause];
            });
        }
    }
}

@end



