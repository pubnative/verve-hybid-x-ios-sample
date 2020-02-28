//
//  Config.h
//  KwizzadRTASample
//
//  Created by Fares Ben Hamouda on 28.02.20.
//  Copyright © 2020 Fares Ben Hamouda. All rights reserved.
//


@interface Config : NSObject 

+ (Config *)sharedInstance;

@property (strong, nonatomic) NSString* sdkToken;
@property (strong, nonatomic) NSString* placement;

@end

