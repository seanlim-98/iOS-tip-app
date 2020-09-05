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
    let defaults = UserDefaults.standard;
    let curr_weight = [1, 0.75, 0.84]
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Calculator"
    }
    
    func currency_conversion() {
        let bill_temp = Double(billAmountTextField.text!) ?? 0
        let converted_value = bill_temp * Double(curr_weight[defaults.integer(forKey:"currency")]/curr_weight[old_curr])
        billAmountTextField.text = String(format: "%.2f", converted_value)
        calculateTip(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        currency_conversion()
        overrideUserInterfaceStyle = defaults.bool(forKey: "DarkModeOn") == true ?  .dark : .light
        
    }
    
    @IBAction func calculateTip(_ sender: Any) {
        let bill = Double(billAmountTextField.text!) ?? 0
        let tipPercentages = [0.15,0.18,0.20]
        let currencies = ["$", "£", "€"]
        
        let tip = bill * tipPercentages[defaults.integer(forKey: "selected")]
        let total = bill + tip
        
        let curr_symbol = currencies[defaults.integer(forKey: "currency")]
        
        tipPercentageLabel.text = curr_symbol + String(format:"%.2f", tip)
        totalLabel.text = curr_symbol + String(format:"%.2f", total)
        
        old_curr = defaults.integer(forKey: "currency")
    }
}

