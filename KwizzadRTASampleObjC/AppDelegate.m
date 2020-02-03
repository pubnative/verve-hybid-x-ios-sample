//
//  AppDelegate.m
//  KwizzadRTASampleObjC
//
//  Created by Fares Ben Hamouda on 07.01.20.
//  Copyright © 2020 Fares Ben Hamouda. All rights reserved.
//

#import "AppDelegate.h"
#import <KwizzadRTA/KwizzadRTA-Swift.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [KwizzadRTA setTestMode:YES];
    [KwizzadRTA setDebugMode:YES];
    
    [KwizzadRTA configureWith:@"rta_ios" completion:^(BOOL finished) {
    }];
    
    return YES;
}

@end
