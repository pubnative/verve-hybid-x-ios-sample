//
//  AppDelegate.m
//  KwizzadRTASampleObjC
//
//  Created by Fares Ben Hamouda on 07.01.20.
//  Copyright © 2020 Fares Ben Hamouda. All rights reserved.
//

#import "AppDelegate.h"
#import <KwizzadRTA/KwizzadRTA-Swift.h>
#import "Config.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [KwizzadRTA setTestMode:YES];
    [KwizzadRTA setDebugMode:YES];

    Config* config = [Config sharedInstance];
    config.sdkToken = @"rta_ios";
    config.placement = @"test";
    [KwizzadRTA configureWith:config.sdkToken completion:^(BOOL finished) {
    }];
    
    return YES;
}

@end
