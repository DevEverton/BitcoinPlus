//
//  ExchangeVC.swift
//  Bitcoin+
//
//  Created by Everton Carneiro on 27/09/17.
//  Copyright © 2017 Everton. All rights reserved.
//

import UIKit

class ExchangeVC: UIViewController {
    
    @IBOutlet weak var changeSidesButton: UIButton!
    @IBOutlet weak var bitcoinSymbol: UIImageView!
    @IBOutlet weak var currencySymbol: UILabel!
    @IBOutlet weak var currencyChange: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var buyLabel: UILabel!
    @IBOutlet weak var sellLabel: UILabel!

    
    
    
    var bitcoinSymbolLocation: CGPoint!
    var currencySymbolLocation: CGPoint!
    
    var bitcoinData = [Bitcoin]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Bitcoin.bitcoinPrice(currency: "USD") { (results: [Bitcoin]) in
            print(results)

        }
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "bitcoinIcon"))
        //self.amountTextField.font = UIFont(name: "Courier New", size: 45)
        bitcoinSymbolLocation = bitcoinSymbol.center
        currencySymbolLocation = currencySymbol.center
        getData()



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
    
    
    
    func getData() {
        
        Bitcoin.bitcoinPrice(currency: "BRL") { (results:[Bitcoin]?) in
            if let bitcoinResults = results {
                self.bitcoinData = bitcoinResults
                Functions.performUIUpdatesOnMain {
                  //  self.tableView.reloadData()
                    let bitcoinObject = self.bitcoinData[0]
                    self.lastLabel.text = Functions.formatToCurrency(symbol: bitcoinObject.symbol, number: String(bitcoinObject.last))
                    self.buyLabel.text = Functions.formatToCurrency(symbol: bitcoinObject.symbol, number: String(bitcoinObject.buy))
                    self.sellLabel.text = Functions.formatToCurrency(symbol: bitcoinObject.symbol, number: String(bitcoinObject.sell))
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
        getData()
        
    }
    




}
