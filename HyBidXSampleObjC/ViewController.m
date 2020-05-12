//
//  ViewController.m
//  HyBidXSampleObjC
//
//  Created by Fares Ben Hamouda on 07.01.20.
//  Copyright © 2020 Fares Ben Hamouda. All rights reserved.
//

#import "ViewController.h"
#import <HyBidX/HyBidX-Swift.h>
#import "Config.h"

@interface ViewController () <HyBidXDelegate>

@property (weak, nonatomic) IBOutlet UITextView *debugTextView;
@property (weak, nonatomic) IBOutlet UIButton *btnShowAd;
@property (weak, nonatomic) IBOutlet UILabel *labelSDKVersion;

@end

@implementation ViewController

HyBidXPlacement* kwizzad;

- (void) viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"HyBidX Sample (ObjC)"];
    
    _labelSDKVersion.text = [NSString stringWithFormat:@"SDK Version: %@", [HyBidX sdkVersion]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    kwizzad = [[HyBidXPlacement alloc]initWith:[Config sharedInstance].placement delegate:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [kwizzad load];
        [self->_debugTextView insertText: [NSString stringWithFormat:@"\n start loading placement %@", [Config sharedInstance].placement]];
    });
}

- (IBAction)loadAdClicked:(id)sender {
    [kwizzad preloadAdsManually];
    [_debugTextView insertText: [NSString stringWithFormat:@"\n reloading placement %@", [Config sharedInstance].placement]];
}

- (IBAction)showAdClicked:(id)sender {
    [kwizzad showAdFrom:self];
}

- (IBAction)showDebugScreen:(id)sender {
    [HyBidX showDebugScreenFrom:self instances: [NSArray arrayWithObjects: kwizzad, nil]];
}

- (IBAction)showConsentScreen:(id)sender {
    [HyBidX showConsentScreenFrom:self instances: [NSArray arrayWithObjects: kwizzad, nil] completion:^(BOOL consentGiven) {
        [self->_debugTextView insertText: [NSString stringWithFormat:@"\n consent status: %@", consentGiven ? @"true" : @"false"]];
    }];
}

// MARK: HyBidX Delegate

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

- (void)onAdOpenedWithPlacementId:(NSString *)placementId {
    [_debugTextView insertText: [NSString stringWithFormat:@"\n ad is opened on placement %@", placementId]];
}

- (void)onAdClickedWithPlacementId:(NSString *)placementId {
    [_debugTextView insertText: [NSString stringWithFormat:@"\n ad is clicked on placement %@", placementId]];
}

- (void)onConsentShouldBeUpdatedWithPlacementId:(NSString *)placementId {
    [_debugTextView insertText: [NSString stringWithFormat:@"\n Consent not given or should be updated"]];
}

@end
