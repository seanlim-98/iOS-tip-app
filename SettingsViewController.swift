//
//  SettingsViewController.swift
//  TipCalc
//
//  Created by Sean Lim on 9/5/20.
//  Copyright © 2020 Sean Lim. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let defaults = UserDefaults.standard

    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet var buttons: [UIButton]!
    
    @IBOutlet var currencyOptions: [UIButton]!
    
    func resetButtonStates(tagNum: intmax_t, btnList: [UIButton]) {
        for button in btnList {
            if(button.tag != tagNum) {
                button.isSelected = false
            }
        }
    }
    
    @IBAction func btnTapped(_ sender: UIButton) {
        let selectedTagNum = sender.tag
        resetButtonStates(tagNum: selectedTagNum, btnList: self.buttons)
        if let button = sender as? UIButton {
            if !button.isSelected {
                button.isSelected = true
            }
        }
        defaults.set(selectedTagNum, forKey: "selected")
        defaults.synchronize()
    }
    
    @IBAction func selectCurrency(_ sender: UIButton) {
        let selectedCurrTag = sender.tag
        resetButtonStates(tagNum: selectedCurrTag, btnList: self.currencyOptions)
        if let button = sender as? UIButton {
            if !button.isSelected {
                button.isSelected = true
            }
        }
        defaults.set(selectedCurrTag, forKey: "currency")
        defaults.synchronize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.buttons[defaults.integer(forKey: "selected")].isSelected = true;
        self.darkModeSwitch.isOn = defaults.bool(forKey:"DarkModeOn")
        self.currencyOptions[defaults.integer(forKey: "currency")].isSelected = true;
    }
    
    @IBAction func darkModeToggle(_ sender: UISwitch) {
        sender.isOn == true ? defaults.set(true, forKey: "DarkModeOn") : defaults.set(false, forKey: "DarkModeOn")
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
