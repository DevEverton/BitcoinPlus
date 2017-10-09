//
//  CalculatorVC.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 09/10/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit

class CalculatorVC: UIViewController {
    
    @IBOutlet weak var currencyLabelTop: UILabel!
    @IBOutlet weak var currencyLabelBottom: UILabel!
    @IBOutlet weak var typedNumberTop: UILabel!
    @IBOutlet weak var resultNumberBottom: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        typedNumberTop.text = "0,00"
        Variables.typedValue = "000"
    }
    
    
    
    @IBAction func numberButton(_ sender: Any) {
        
        Variables.typedValue += (sender as AnyObject).title(for: .normal)!
        if Variables.typedValue.hasPrefix("0"){
            Variables.typedValue.remove(at: Variables.typedValue.startIndex)
        }
        Variables.typedValue.insert(".", at: Variables.typedValue.index(Variables.typedValue.endIndex, offsetBy: -2))
        let tempStr = Functions.formatter(number: Variables.typedValue)
        typedNumberTop.text = tempStr
        let tempStr2 = tempStr.replacingOccurrences(of: "[,.]", with: "",options: .regularExpression)
        Variables.typedValue = tempStr2
    }

    @IBAction func eraseButton(_ sender: Any) {
        
        if Variables.typedValue.characters.count < 4 {
            Variables.typedValue.insert("0", at: Variables.typedValue.startIndex)
        }
        var erasedNumber = String(Variables.typedValue.characters.dropLast(1))
        erasedNumber.insert(".", at: erasedNumber.index(erasedNumber.endIndex, offsetBy: -2))
        let tempStr = Functions.formatter(number: erasedNumber)
        typedNumberTop.text = tempStr
        let tempStr2 = tempStr.replacingOccurrences(of: "[,.]", with: "",options: .regularExpression)
        Variables.typedValue = tempStr2
        
    }
    
    @IBAction func equalsButton(_ sender: Any) {
        
        let valueToConvert = Functions.castToDouble(stringNumber: Variables.typedValue)!
        
        
    }
    

}
