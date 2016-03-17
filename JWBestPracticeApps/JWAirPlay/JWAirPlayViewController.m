//
//  JWAirPlayViewController.m
//  JWBestPracticeApps
//
//  Created by Karim Mourra on 3/17/16.
//  Copyright © 2016 Karim Mourra. All rights reserved.
//

#import "JWAirPlayViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface JWAirPlayViewController ()

@property (nonatomic) MPVolumeView *airPlayView;

@end

@implementation JWAirPlayViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self setUpAirPlayButton];
}

- (void)setUpAirPlayButton
{
    CGFloat buttonWidth = 44;
    CGFloat buttonCoordinateX = self.player.view.frame.size.width - buttonWidth - 5;
    self.airPlayView =[[MPVolumeView alloc] initWithFrame:CGRectMake(buttonCoordinateX, 0, buttonWidth, buttonWidth)];
    [self.airPlayView setShowsVolumeSlider:NO];
    self.airPlayView.backgroundColor = [UIColor clearColor];
    self.airPlayView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.player.view addSubview:self.airPlayView];
}

@end
