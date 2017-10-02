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
    var currentCurrency = "USD"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Bitcoin.bitcoinPrice(currency: "USD") { (results: [Bitcoin]) in
            print(results)

        }
//        picker.delegate = self
//        picker.dataSource = self
        
        
        picker = UIPickerView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        picker.backgroundColor = .white
        
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("donePicker")))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: Selector(("donePicker")))
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textFieldCurrency.inputView = picker

        self.navigationItem.titleView = UIImageView(image: UIImage(named: "bitcoinIcon"))
        //self.amountTextField.font = UIFont(name: "Courier New", size: 45)
        bitcoinSymbolLocation = bitcoinSymbol.center
        currencySymbolLocation = currencySymbol.center
        getData(of: "USD")



    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return bitcoinData.count
//    }
//    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Last"
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ResultsCell
// 
//        let bitcoinObject = bitcoinData[indexPath.section]
//        cell.valueLabel.text = "Last: " + Functions.formatToCurrency(symbol: bitcoinObject.symbol, number: String(bitcoinObject.last))
//        
//        return cell
//        
//    }
    
    
    
    func getData(of currency: String) {
        
        Bitcoin.bitcoinPrice(currency: currency) { (results:[Bitcoin]?) in
            if let bitcoinResults = results {
                self.bitcoinData = bitcoinResults
                Functions.performUIUpdatesOnMain {
                  //  self.tableView.reloadData()
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
        getData(of: currentCurrency)
        
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
        currentCurrency = Constants.currencyArr[row]
        self.view.endEditing(false)
        
    }
    
    




}
