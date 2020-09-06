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
    @IBOutlet weak var pencilIcon: UIButton!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBAction func toggleCurrMenu(_ sender: Any) {
        for button in currencyOptions {
            UIView.transition(with: button, duration: 0.3,
                options: .transitionCrossDissolve,
                animations: {
                    button.isHidden = !button.isHidden
            })
        }
    }
    
    @IBOutlet var currencyOptions: [UIButton]!
    
    // Deselects settings once others are chosen
    func resetButtonStates(tagNum: intmax_t, btnList: [UIButton]) {
        for button in btnList {
            if(button.tag != tagNum) {
                button.isSelected = false
            }
        }
    }
    
    // Select tip percentage
    @IBAction func btnTapped(_ sender: UIButton) {
        let selectedPercTagNum = sender.tag
        resetButtonStates(tagNum: selectedPercTagNum, btnList: self.buttons) // update button state
        if let button = sender as? UIButton {
            if !button.isSelected {
                button.isSelected = true
            }
        }
        defaults.set(selectedPercTagNum, forKey: "selected")
        defaults.synchronize()
    }
    
    // Select currency
    @IBAction func selectCurrency(_ sender: UIButton) {
        let selectedCurrTag = sender.tag
        resetButtonStates(tagNum: selectedCurrTag, btnList: self.currencyOptions) // update button state
        if let button = sender as? UIButton {
            if !button.isSelected {
                button.isSelected = true
            }
        }
        defaults.set(selectedCurrTag, forKey: "currency")
        self.currencyLabel.text = currencyOptions[defaults.integer(forKey:"currency")].currentTitle
        defaults.synchronize()
    }
    
    // data persistence
    override func viewWillAppear(_ animated: Bool) {
        self.buttons[defaults.integer(forKey: "selected")].isSelected = true;
        self.darkModeSwitch.isOn = defaults.bool(forKey:"DarkModeOn")
        overrideUserInterfaceStyle = defaults.bool(forKey: "DarkModeOn") == true ?  .dark : .light
        self.currencyOptions[defaults.integer(forKey: "currency")].isSelected = true;
        self.currencyLabel.text = currencyOptions[defaults.integer(forKey:"currency")].currentTitle
    }
    
    // Toggle dark mode switch
    @IBAction func darkModeToggle(_ sender: UISwitch) {
        sender.isOn == true ? defaults.set(true, forKey: "DarkModeOn") : defaults.set(false, forKey: "DarkModeOn")
        overrideUserInterfaceStyle = defaults.bool(forKey: "DarkModeOn") == true ?  .dark : .light
        defaults.synchronize()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for button in currencyOptions {
            button.isHidden = true
        }
    }
}
