//
//  ConfigurationViewController.swift
//  KwizzadRTASample
//
//  Created by Fares Ben Hamouda on 26.02.20.
//  Copyright © 2020 Fares Ben Hamouda. All rights reserved.
//

import UIKit
import KwizzadRTA

class ConfigurationViewController: UIViewController {

    @IBOutlet weak var textFieldSDKToken: UITextField!
    @IBOutlet weak var textFieldPlacement: UITextField!
    
    @IBOutlet weak var textFieldUserID: UITextField!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var pickerViewGender: UIPickerView!
    
    let genders = ["male", "female", "not set"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialValues()
    }
    
    func initialValues() {
        textFieldSDKToken.text = sdkToken
        textFieldPlacement.text = placement
        pickerViewGender.selectRow(genders.count-1, inComponent: 0, animated: false)

        let userData: [String: Any] = KwizzadRTA.userData()
        
        if let userID = userData["userID"] as? String {
            textFieldUserID.text = userID
        }
        
        if let ageString = userData["age"] as? String {
            textFieldAge.text = ageString
        }
        
        if let gender = userData["gender"] as? String {
            pickerViewGender.selectRow(genders.firstIndex(of: gender) ?? genders.count-1, inComponent: 0, animated: false)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
            if let textFieldSDKToken = textFieldSDKToken.text, textFieldSDKToken != sdkToken {
                sdkToken = textFieldSDKToken
                KwizzadRTA.configure(with: sdkToken)
            }
            if let textFieldPlacement = textFieldPlacement.text, textFieldPlacement != "" {
                placement = textFieldPlacement
            }
            if let userID = textFieldUserID.text, userID != "" {
                KwizzadRTA.identifyUser(with: userID)
            }
            if let ageString = textFieldAge.text, let age = Int(ageString) {
                KwizzadRTA.setUserAge(with: age)
            }
            if pickerViewGender.selectedRow(inComponent: 0) != genders.count-1 {
                KwizzadRTA.setUserGender(with: genders[pickerViewGender.selectedRow(inComponent: 0)])
            }
        }
    }
}

extension ConfigurationViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genders.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genders[row]
    }
    
}

extension ConfigurationViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
