
# Get Started
This guide is for publishers who want to monetize an iOS app with Kwizzad RTA.

Integrating the Kwizzad RTA SDK into an app is the first step toward displaying ads and earning revenue.   

## Prerequisites

- XCode

- `min deployment target` 9.0
- add those lines to Info.plist: 

```
	<key>NSAppTransportSecurity</key>
	<dict>
		<key>NSAllowsArbitraryLoads</key>
		<true/>
	</dict>
    
     <key>GADApplicationIdentifier</key>
    <string>GOOGLE_AD_TOKEN_GET_FROM_SUPPORT</string>
    <key>GADIsAdManagerApp</key>
    <true/>
    
```

## Add the SDK to your iOS project

- Integrate KwizzadRTA framework into your project via cocoapods.

Add this lines to your Podfile:

```ruby

pod 'KwizzadRTA'

```

Once that's done, save the file and perform a pod install.

- Fix incompatible Dependency

```ruby
sed -i '' 's/^module AATKit/framework module AATKit/' Pods/AATKit/aat/AATKit.framework/Versions/A/Modules/module.modulemap
```
This fixes the Compile Error: Include of non-modular header inside framework module 'KwizzadRTA'
Alternative Manual Fix:
- Open the file under Pods/AATKit/aat/AATKit.framework/Versions/A/Modules/module.modulemap
- add the keyword 'framework' at the very begining.

## Integration

### Initialize

Before loading and showing ads, initialize the library by calling  `KwizzadRTA.shared.configre(with: token)` .  This will fetch the ad configuration.
Additinaly, you can receive a completion bool to know if the SDK is finished configuring.

```swif
KwizzadRTA.configure(with: "token") { (status) in
    //KwizzadRTA is configured you can start loading ads.
}
```

Start loading rta objects in your view controller and conform it KwizzadRTADelegate protocol:
```swift

KwizzadRTA.shared.load(placement: "PLACEMENT_HERE", delegate: self)

// lifecycle callbacks
extension ViewController: KwizzadRTADelegate {

  func onAdAvailable(placementId: String) {}
  func onAdFailedToLoad(placementId: String) {}
  func onAdError(placementId: String, error: String) {}
  func onAdCanceled(placementId: String) {}
  func onAdFinished(placementId: String) {}
  //optionals callbacks
  func onAdOpened(placementId: String) {}
  func onAdClicked(placementId: String) {}
}
```

### Show

If an ad is preloaded successfully you can show it by doing the following: 

```swift
KwizzadRTA.shared.showAd(from: viewController)
```



You don't have to reload ads, it is done automatically. As soon as another ad is preloaded, you will receive  ```onAdAvailable``` delegate function.



## Ad providers

The Following providers are integrated within the SDK:

 - VAST/VPAID
 - AdMob (Interstitials, Rewarded Videos)
 - Facebook Audience Network (Interstitials, Rewarded Videos)
 - IronSource (Interstitials, Rewarded Videos) (coming soon)
 - Addapptr; including:
	 - Google Ad Manager (Interstitials, Rewarded Videos)
	 - SmartAdSErver (Interstitials)
	 - MoPub (Interstitials)
	 - Smaato (Interstitials)
	 - Applovin (Interstitials)
	 - Unity Ads (Interstitials, Rewarded Videos)
	 - Vungle (Interstitials)
	 - Ad Colony (Interstitials, Rewarded Videos)
	 - InMobi (Interstitials)
 - Fyber Marketplace (Interstitials, Rewarded Videos)
 - SpotX (VAST/VPAID)
 - FeedAd (Interstitials)
