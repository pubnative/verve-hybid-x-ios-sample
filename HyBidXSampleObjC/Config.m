//
//  Config.m
//  KwizzadRTASampleObjC
//
//  Created by Fares Ben Hamouda on 28.02.20.
//  Copyright © 2020 Fares Ben Hamouda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Config.h"

@implementation Config

+ (Config *)sharedInstance
{
    static Config *myInstance = nil;

    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
    }
    return myInstance;
}
@end
