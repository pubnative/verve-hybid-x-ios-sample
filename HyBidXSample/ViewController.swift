//
//  ViewController.swift
//  HyBidXSample
//
//  Created by Fares Ben Hamouda on 25.10.19.
//  Copyright © 2019 Fares Ben Hamouda. All rights reserved.
//

import UIKit
import HyBidX

class ViewController: UIViewController {

    var placement: HyBidXPlacement?

    @IBOutlet weak var buttonShowAd: UIButton!
    @IBOutlet weak var textViewDebug: UITextView!
    @IBOutlet weak var labelVersion: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "HyBidX Sample (Swift)"
        labelVersion.text?.append(HyBidX.sdkVersion())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.placement = HyBidXPlacement(with: placement, delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now()+1) {
            self.placement?.load()
            self.textViewDebug.appendText(with: "start loading placement \(placement)")
        }
    }
    
    @IBAction func loadAdClicked(_ sender: Any) {
        self.placement?.preloadAdsManually()
        self.textViewDebug.appendText(with: "reloading placement \(placement)")
    }
    
    @IBAction func showAdClicked(_ sender: Any) {
        HyBidX.setCustomParams(["test": "test"])
        placement?.showAd(from: self)
    }

    @IBAction func showDebugScreen(_ sender: Any) {
        guard let placement = placement else {return}
        HyBidX.showDebugScreen(from: self, instances: [kwizzad])
    }
    
    @IBAction func showConsentScreen(_ sender: Any) {
        guard let placement = placement else {return}
        HyBidX.showConsentScreen(from: self, instances: [placement]) { (consentGiven) in
            self.textViewDebug.appendText(with: "consent status: \(consentGiven)")
        }
    }
}

extension ViewController: HyBidXDelegate {
        
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
    func onAdOpened(placementId: String) {
        self.textViewDebug.appendText(with: "ad is opened on placement \(placementId)")
    }
    func onAdClicked(placementId: String) {
        self.textViewDebug.appendText(with: "ad is clicked on placement \(placementId)")
    }
    func onConsentShouldBeUpdated(placementId: String) {
        self.textViewDebug.appendText(with: "Consent not given or should be updated")
    }
}

// MARK: Helpers

extension UITextView {
    
    func appendText(with text: String) {
        self.text.append("\n"+text)
    }
    
}

