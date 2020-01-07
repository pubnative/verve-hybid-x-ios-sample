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

    var kwizzad = KwizzadRTA()
    let placement = "test"

    @IBOutlet weak var buttonShowAd: UIButton!
    @IBOutlet weak var textViewDebug: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "KwizzadRTA Sample"
    }

    @IBAction func loadAdClicked(_ sender: Any) {
        self.kwizzad.load(placement: placement, delegate: self)
        self.textViewDebug.appendText(with: "start loading placement \(self.placement)")
    }
    
    @IBAction func showAdClicked(_ sender: Any) {
        KwizzadRTA.setCustomParams(["test": "test"])
        kwizzad.showAd(from: self)
    }

    @IBAction func showDebugScreen(_ sender: Any) {
        KwizzadRTA.showDebugScreen(from: self, instances: [kwizzad])
    }
    
    @IBAction func showConsentScreen(_ sender: Any) {
        KwizzadRTA.showConsentScreen(from: self) { (consentGiven) in
            self.textViewDebug.appendText(with: "consent status: \(consentGiven)")
        }
    }
}

extension ViewController: KwizzadRTADelegate {
        
    func onAdAvailable(placementId: String) {
        buttonShowAd.isEnabled = true
        self.textViewDebug.appendText(with: "an ad is preloaded on placement \(placementId)")
    }
    
    func onAdFailedToLoad(placementId: String) {
        self.textViewDebug.appendText(with: "ad failed to load on placement \(placementId)")
    }

    func onAdCanceled(placementId: String, params: [String : Any]?) {
        self.textViewDebug.appendText(with: "ad is cancelled on placement \(placementId)")
    }
    
    func onAdError(placementId: String, error: String, params: [String : Any]?) {
        self.textViewDebug.appendText(with: "an error occured on placement \(placementId), error: \(error)")
    }
    
    func onAdPassback(placementId: String, params: [String : Any]?) {
        self.textViewDebug.appendText(with: "a passback occured on placement \(placementId)")
    }
    
    func onAdFinished(placementId: String, params: [String : Any]?) {
        self.textViewDebug.appendText(with: "ad is finished on placement \(placementId)")
    }
    
    //optionals callbacks
    func onAdOpened(placementId: String) {}
    func onAdClicked(placementId: String) {}
    
}

// MARK: Helpers

extension UITextView {
    
    func appendText(with text: String) {
        self.text.append("\n"+text)
    }
    
}

