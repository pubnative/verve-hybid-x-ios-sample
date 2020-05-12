//
//  AppDelegate.swift
//  HyBidXSample
//
//  Created by Fares Ben Hamouda on 18.10.19.
//  Copyright © 2019 Fares Ben Hamouda. All rights reserved.
//

import UIKit
import HyBidX

// CONFIGUTRATION
var sdkToken = "rta_ios"
var placement = "test"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        HyBidX.setTestMode(true)
        HyBidX.setDebugMode(true)
        HyBidX.configure(with: sdkToken) { (status) in }

        return true
    }

}

