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
    
    var bitcoinData = [Bitcoin]()
    var lastValue = Double()
    
    //IMPLEMENT THE LOGIC FOR CHANGE SIDES OF THE CONVERSOR

    override func viewDidLoad() {
        super.viewDidLoad()
        Variables.calcTopCurrency = Constants.BTC
        currencyLabelTop.text = Variables.calcTopCurrency
        currencyLabelBottom.text = Variables.currentCurrency

    }
    
    override func viewDidAppear(_ animated: Bool) {
        typedNumberTop.text = "0,00"
        Variables.typedValue = "000"
        getLastValue(of: Variables.currentCurrency)

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
       // resultNumberBottom.text = "0,00"
        let convertedValue = Functions.castToDouble(stringNumber: Variables.typedValue)!
        resultNumberBottom.text = Functions.formatter(number: String(Calculate(convertedValue, topNumber: .bitcoin)))
        
    }
    
    @IBAction func equalsButton(_ sender: Any) {
        
        let convertedValue = Functions.castToDouble(stringNumber: Variables.typedValue)!
        resultNumberBottom.text = Functions.formatter(number: String(Calculate(convertedValue, topNumber: .bitcoin)))
        
    }
    
    func Calculate(_ amount: Double,topNumber: topCalculatorNumber) -> Double {
        var result = Double()
        switch topNumber {
        case .bitcoin:
            result = amount * lastValue
        case .currency:
            result = amount / lastValue
            
        }
         return result
        
    }
    
    func getLastValue(of currency: String){
        Bitcoin.bitcoinPrice(currency: currency) { (results:[Bitcoin]?) in
            if let bitcoinResults = results {
                self.bitcoinData = bitcoinResults
                Functions.performUIUpdatesOnMain {
                    let bitcoinObject = self.bitcoinData[0]
                    self.lastValue = bitcoinObject.last

                }

            }

        }
    }
    

}
