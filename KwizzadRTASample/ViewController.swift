//
//  ViewController.swift
//  KwizzadRTASample
//
//  Created by Fares Ben Hamouda on 18.10.19.
//  Copyright © 2019 Fares Ben Hamouda. All rights reserved.
//

import UIKit
import KwizzadRTA

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        KwizzadRTA.shared.load(placement: "test", delegate: self)

    }

    @IBAction func showAdClicked(_ sender: Any) {
        KwizzadRTA.shared.showAd(from: self)
    }
    
}

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
