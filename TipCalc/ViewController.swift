//
//  ViewController.swift
//  TipCalc
//
//  Created by Sean Lim on 9/5/20.
//  Copyright © 2020 Sean Lim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    
    var old_curr = 0
    var curr_sym = "$"
    let defaults = UserDefaults.standard;
    
    let curr_weight = [1, 0.75, 0.84]
    let currencies = ["$", "£", "€"]
    
    func findIndexOfCurrency() -> Int { // Finds the correct symbol based on locale
        var iterator = 0
        for curr in currencies {
            if (Locale.current.currencySymbol! == curr) {
                return iterator
            } else {
                iterator+=1
                
            }
        }
        return iterator
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
        defaults.set(findIndexOfCurrency(), forKey:"currency")
    }
    
    // Currency conversion for existing text-field data
    func currency_conversion() {
        let bill_temp = Double(billAmountTextField.text!) ?? 0
        let converted_value = bill_temp * Double(curr_weight[defaults.integer(forKey:"currency")]/curr_weight[old_curr])
        billAmountTextField.text = String(format: "%.2f", converted_value)
        calculateTip(self) // call calculation function after initial conversion
    }
    
    // Render changes after settings are altered
    override func viewWillAppear(_ animated: Bool) {
        curr_sym = Locale.current.currencySymbol! // get current locale currency
        currency_conversion()
        overrideUserInterfaceStyle = defaults.bool(forKey: "DarkModeOn") == true ?  .dark : .light
    }
    
    // Tip calculation function, append currency symbol
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [0.15,0.18,0.20]
        
        let tip = bill * tipPercentages[defaults.integer(forKey: "selected")]
        let total = bill + tip
        
        if (currencies[defaults.integer(forKey: "currency")] != curr_sym) {
            curr_sym = currencies[defaults.integer(forKey: "currency")] // account for manual change of currency
        }
        
        tipPercentageLabel.text = curr_sym + String(format:"%.2f", tip)
        totalLabel.text = curr_sym + String(format:"%.2f", total)
        
        old_curr = defaults.integer(forKey: "currency")
    }
}

