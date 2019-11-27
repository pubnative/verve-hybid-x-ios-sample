//
//  ViewController.swift
//  KwizzadRTASample
//
//  Created by Fares Ben Hamouda on 25.10.19.
//  Copyright © 2019 Fares Ben Hamouda. All rights reserved.
//

import UIKit
import KwizzadRTA

class ViewController: UIViewController {

    var firstPlacementKwizzad = KwizzadRTA()
    var secondPlacementKwizzad = KwizzadRTA()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func loadAdClicked(_ sender: Any) {
        let delay = AppDelegate.isConfigured ? 0.0 : 3.0
        loadAd(with: delay)
    }
    
    func loadAd(with delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: .now()+delay) {
            self.firstPlacementKwizzad.load(placement: "premium", delegate: self)
            self.secondPlacementKwizzad.load(placement: "backfill", delegate: self)
        }
    }
    
    @IBAction func showAdClicked(_ sender: Any) {
        KwizzadRTA.setCustomParams(["test": "test"])
        firstPlacementKwizzad.showAd(from: self)
    }

    @IBAction func showDebugScreen(_ sender: Any) {
        KwizzadRTA.showDebugScreen(from: self, instances: [firstPlacementKwizzad, secondPlacementKwizzad])
    }
}

extension ViewController: KwizzadRTADelegate {
        
    func onAdAvailable(placementId: String) {
        print("available")
    }
    
    func onAdFailedToLoad(placementId: String) {
        
    }

    func onAdCanceled(placementId: String, params: [String : Any]?) {
        
    }
    
    func onAdError(placementId: String, error: String, params: [String : Any]?) {
        
    }
    
    func onAdPassback(placementId: String, params: [String : Any]?) {
        
    }
    
    func onAdFinished(placementId: String, params: [String : Any]?) {
        print("onAdFinished: ", params ?? [:])
    }
    
    //optionals callbacks
    func onAdOpened(placementId: String) {}
    func onAdClicked(placementId: String) {}
    
}

