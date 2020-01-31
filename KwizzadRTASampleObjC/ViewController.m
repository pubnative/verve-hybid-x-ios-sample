//
//  ViewController.m
//  KwizzadRTASampleObjC
//
//  Created by Fares Ben Hamouda on 07.01.20.
//  Copyright © 2020 Fares Ben Hamouda. All rights reserved.
//

#import "ViewController.h"
#import <KwizzadRTA/KwizzadRTA-Swift.h>
@interface ViewController () <KwizzadRTADelegate>

@property (weak, nonatomic) IBOutlet UITextView *debugTextView;
@property (weak, nonatomic) IBOutlet UIButton *btnShowAd;

@end

@implementation ViewController

KwizzadRTA* kwizzad;
NSString* placement = @"test";

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"KwizzadRTA Sample ObjC"];
    
    kwizzad = [[KwizzadRTA alloc]init];
}

- (IBAction)loadAdClicked:(id)sender {
    [kwizzad loadWithPlacement:@"test" delegate:self];
    [_debugTextView insertText: [NSString stringWithFormat:@"\n start loading placement %@", placement]];
}

- (IBAction)showAdClicked:(id)sender {
    [kwizzad showAdFrom:self];
}

- (IBAction)showDebugScreen:(id)sender {
    [KwizzadRTA showDebugScreenFrom:self instances: [NSArray arrayWithObjects: kwizzad, nil]];
}

- (IBAction)showConsentScreen:(id)sender {
    [KwizzadRTA showConsentScreenFrom:self instances: [NSArray arrayWithObjects: kwizzad, nil] completion:^(BOOL consentGiven) {
        [self->_debugTextView insertText: [NSString stringWithFormat:@"\n consent status: %@", consentGiven ? @"true" : @"false"]];
    }];
}

// MARK: KwizzadRTA Delegate

- (void)onAdAvailableWithPlacementId:(NSString * _Nonnull)placementId {
    [_btnShowAd setEnabled:YES];
    [_debugTextView insertText: [NSString stringWithFormat:@"\n an ad is preloaded on placement %@", placementId]];
}

- (void)onAdCanceledWithPlacementId:(NSString * _Nonnull)placementId params:(NSDictionary<NSString *,id> * _Nullable)params {
    [_debugTextView insertText: [NSString stringWithFormat:@"\n ad is cancelled on placement %@", placementId]];
}

- (void)onAdErrorWithPlacementId:(NSString * _Nonnull)placementId error:(NSString * _Nonnull)error params:(NSDictionary<NSString *,id> * _Nullable)params {
    [_debugTextView insertText: [NSString stringWithFormat:@"\n an error occured on placement %@, error: %@", placementId, error]];
}

- (void)onAdFailedToLoadWithPlacementId:(NSString * _Nonnull)placementId {
    [_debugTextView insertText: [NSString stringWithFormat:@"\n ad failed to load on placement %@", placementId]];

}

- (void)onAdFinishedWithPlacementId:(NSString * _Nonnull)placementId params:(NSDictionary<NSString *,id> * _Nullable)params {
    [_debugTextView insertText: [NSString stringWithFormat:@"\n ad is finished on placement %@", placementId]];
}

- (void)onAdPassbackWithPlacementId:(NSString * _Nonnull)placementId params:(NSDictionary<NSString *,id> * _Nullable)params {
    [_debugTextView insertText: [NSString stringWithFormat:@"\n a passback occured on placement %@", placementId]];
}


@end
