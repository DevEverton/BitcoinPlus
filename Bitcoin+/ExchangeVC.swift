//
//  ExchangeVC.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 27/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var changeSidesButton: UIButton!
    @IBOutlet weak var bitcoinSymbol: UIImageView!
    @IBOutlet weak var currencySymbol: UILabel!
    @IBOutlet weak var currencyChange: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var sellLabel: UILabel!
    @IBOutlet weak var textFieldCurrency: UITextField!

    var picker = UIPickerView()
    
    
    var bitcoinSymbolLocation: CGPoint!
    var currencySymbolLocation: CGPoint!
    
    var bitcoinData = [Bitcoin]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Bitcoin.bitcoinPrice(currency: "USD") { (results: [Bitcoin]) in
            print(results)

        }
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        picker.backgroundColor = UIColor(red:0.30, green:0.30, blue:0.30, alpha:1.0)
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        textFieldCurrency.inputView = picker

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        bitcoinSymbolLocation = bitcoinSymbol.center
        currencySymbolLocation = currencySymbol.center
        Variables.currentCurrency = "USD"
        getData(of: Variables.currentCurrency)

    }


    func getData(of currency: String) {
        
        Bitcoin.bitcoinPrice(currency: currency) { (results:[Bitcoin]?) in
            if let bitcoinResults = results {
                self.bitcoinData = bitcoinResults
                Functions.performUIUpdatesOnMain {
                    let bitcoinObject = self.bitcoinData[0]
                    self.lastLabel.text = Functions.formatToCurrency(number: String(bitcoinObject.last), withSymbol: bitcoinObject.symbol + " ")
                    self.buyLabel.text = Functions.formatToCurrency(number: String(bitcoinObject.buy), withSymbol: bitcoinObject.symbol + " ")
                    self.sellLabel.text = Functions.formatToCurrency(number: String(bitcoinObject.sell), withSymbol: bitcoinObject.symbol + " ")
                }
            }
        }
    }
    
 
    @IBAction func changeSidesButton(_ sender: Any) {
        UIView.animate(withDuration: 0.3) {
            if self.bitcoinSymbolLocation == self.bitcoinSymbol.center {
                self.bitcoinSymbol.center = self.currencySymbolLocation
                self.currencySymbol.center = self.bitcoinSymbolLocation
                self.bitcoinSymbolLocation = self.bitcoinSymbol.center
                self.currencySymbolLocation = self.currencySymbol.center
                
            }
  
        }
    }
    
    @IBAction func reloadTableButton(_ sender: Any) {
        getData(of: Variables.currentCurrency)
        
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Constants.currencyArr.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Constants.currencyArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        currencyChange.text = Constants.currencyArr[row]
        getData(of: Constants.currencyArr[row])
        Variables.currentCurrency = Constants.currencyArr[row]
        self.view.endEditing(false)
        
    }
    


}
